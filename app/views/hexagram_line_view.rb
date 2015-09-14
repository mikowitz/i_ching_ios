class HexagramLineView < UIView
  attr_reader :line, :dim, :index

  def styleForLine(line, atY: y)
    styleForLine(line, atY: y, index: 0)
  end

  def styleForLine(line, atY: y, index: index)
    @line = line
    @dim = superview.dim
    @index = 6 - index

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
    when 9
      draw_yang_line
      drawChangeCircle
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
    diameter = self.frame.size.height + 24
    top = self.frame.origin.y - 12
    rmq(self.superview).append(ChangeCircleView.alloc.initWithDiameter(diameter, top: top), :change_circle).on(:tap) do |circle|
      show_info_for_line
      circle.highlight
    end
  end

  def drawChangeX
    diameter = self.frame.size.height + 26
    top = self.frame.origin.y - 13
    rmq(self.superview).append(ChangeXView.alloc.initWithDiameter(diameter, top: top), :change_x).on(:tap) do |x|
      show_info_for_line
      x.highlight
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
