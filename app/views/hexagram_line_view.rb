class HexagramLineView < UIView
  attr_reader :line, :dim, :index

  def styleForLine(line, atY: y)
    styleForLine(line, atY: y, index: 0)
  end

  def styleForLine(line, atY: y, index: index)
    @line = line
    @dim = superview.dim
    @index = index + 1

    rmq(self).style do |st|
      st.frame = { t: y, h: dim * 2, w: superview.frame.size.width - dim * 2, l: dim }
      st.background_color = rmq.color.clear
    end
    drawLineSegments
  end

  def drawLineSegments
    case line
    when 0, 8
      draw_yin_line
    when 1, 7
      draw_yang_line
    when 6
      draw_yin_line
      drawChangeX
      draw_ghost_lines
    when 9
      draw_yang_line
      drawChangeCircle
      draw_ghost_lines
    end
  end

  def draw_yang_line # solid
    drawLineSegmentAtX(0, withWidth: self.frame.size.width)
  end

  def draw_yin_line # broken
    drawLineSegmentAtX(0, withWidth: dim * 7)
    drawLineSegmentAtX(dim * 11, withWidth: dim * 7)
  end

  def drawChangeCircle
    diameter = self.frame.size.height + 22
    top = self.frame.origin.y - 11
    rmq(self.superview).append(ChangeCircleView.alloc.initWithDiameter(diameter, top: top), :change_circle).on(:tap) do |circle|
      show_info_for_line
      circle.highlight
    end
  end

  def drawChangeX
    diameter = self.frame.size.height + 24
    top = self.frame.origin.y - 12
    rmq(self.superview).append(ChangeXView.alloc.initWithDiameter(diameter, top: top), :change_x).on(:tap) do |x|
      show_info_for_line
      x.highlight
    end
  end

  def draw_ghost_yang(q)
    q.append(UIView, :ghost_line_segment).style do |st|
      st.frame = { l: 0, w: st.superview.frame.size.width, h: st.superview.frame.size.height / 4, centered: :vertical }
    end
  end

  def draw_ghost_yin(q)
    q.append(UIView, :ghost_line_segment).style do |st|
      st.frame = { l: 0, w: st.superview.frame.size.width / 3, h: st.superview.frame.size.height / 4, centered: :vertical }
    end
    q.append(UIView, :ghost_line_segment).style do |st|
      st.frame = { fr: 0, w: st.superview.frame.size.width / 3, h: st.superview.frame.size.height / 4, centered: :vertical }
    end
  end

  def draw_ghost_lines
    t = self.frame.origin.y + self.superview.frame.origin.y
    rmq(self.superview.superview).append(UIView, :ghost_line_view).style do |st|
      st.frame = { t: t, l: 10, h: self.frame.size.height, w: 40 }
    end.tap do |q|
      if line == 6
        draw_ghost_yin(q)
      elsif line == 9
        draw_ghost_yang(q)
      end
    end

    rmq(self.superview.superview).append(UIView, :ghost_line_view).style do |st|
      st.frame = { t: t, fr: 10, h: self.frame.size.height, w: 40 }
    end.tap do |q|
      if line == 6
        draw_ghost_yang(q)
      elsif line == 9
        draw_ghost_yin(q)
      end
    end
  end

  def show_info_for_line
    number_map = { 6 => "Six", 9 => "Nine" }
    index_map = {
      1 => "at the beginning",
      2 => "in the second place",
      3 => "in the third place",
      4 => "in the fourth place",
      5 => "in the fifth place",
      6 => "at the top"
    }
    title = "#{number_map[line]} #{index_map[index]} means:"
    message = "Danger is at hand. It furthers one to desist"
    self.superview.delegate.show_info_for_line(title, message)
  end

  def drawLineSegmentAtX(x, withWidth: width)
    h = self.frame.size.height - 4
    top = 2
    rmq(self).append(UIView, :hexagram_line_segment).style do |st|
      st.frame = { l: x, h: h, t: top, w: width }
    end
  end
end
