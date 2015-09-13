class HexagramLineView < UIView
  attr_reader :line, :dim

  def styleForLine(line, atY: y)
    @line = line
    @dim = superview.dim

    rmq(self).style do |st|
      st.frame = { t: y, h: dim * 2, w: superview.frame.size.width - dim * 2, l: dim }
      st.background_color = rmq.color.clear
    end
    drawLineSegments
  end

  def drawLineSegments
    case line
    when 0, 8
      drawLineSegmentAtX(0, withWidth: dim * 7)
      drawLineSegmentAtX(dim * 11, withWidth: dim * 7)
    when 1, 7
      drawLineSegmentAtX(0, withWidth: self.frame.size.width)
    when 6
      drawLineSegmentAtX(0, withWidth: dim * 7)
      drawLineSegmentAtX(dim * 11, withWidth: dim * 7)
      drawChangeX
    when 9
      drawLineSegmentAtX(0, withWidth: self.frame.size.width)
      drawChangeCircle
    end
  end

  def drawChangeCircle
    diameter = self.frame.size.height + 24
    top = self.frame.origin.y - 12
    rmq(self.superview).append(ChangeCircleView.alloc.initWithDiameter(diameter, top: top), :change_circle).on(:tap) do |circle|
      circle.highlight
    end
  end

  def drawChangeX
    diameter = self.frame.size.height + 26
    top = self.frame.origin.y - 13
    rmq(self.superview).append(ChangeXView.alloc.initWithDiameter(diameter, top: top), :change_x).on(:tap) do |x|
      x.highlight
    end
  end

  def drawLineSegmentAtX(x, withWidth: width)
    if line == 9 || line == 6
      h = self.frame.size.height - 4
      top = 2
    else
      h = self.frame.size.height
      top = 0
    end
    rmq(self).append(UIView, :hexagram_line_segment).style do |st|
      st.frame = { l: x, h: h, t: top, w: width }
    end
  end
end
