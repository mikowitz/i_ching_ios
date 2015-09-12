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
    diameter = self.frame.size.height + 26
    top = self.frame.origin.y - 13
    rmq(self.superview).append(ChangeCircleView.alloc.initWithDiameter(diameter, top: top), :change_circle).on(:tap) do
    # rmq(self.superview).append(UIView, :change_circle).style do |st|
    #   diameter = self.frame.size.height + 26
    #   st.corner_radius = diameter / 2
    #   st.frame = { h: diameter, w: diameter, t: self.frame.origin.y - 13, centered: :horizontal }
    # end.on(:tap) do
      puts "tapped circle"
    end
  end

  def drawChangeX
    # rmq(self.superview).append(UIView, :change_x_box).style do |st|
    #   diameter = self.frame.size.height + 26
    #   st.frame = { h: diameter, w: diameter, t: self.frame.origin.y - 13, centered: :horizontal }
    # end.on(:tap) do
    #   puts "tapped x"
    # end.tap do |q|
    #   q.append!(UIView, :change_x_line).transform = CGAffineTransformMakeRotation(-45 * Math::PI / 180)
    #   q.append!(UIView, :change_x_line).transform = CGAffineTransformMakeRotation(45 * Math::PI / 180)
    # end
    diameter = self.frame.size.height + 26
    top = self.frame.origin.y - 13
    rmq(self.superview).append(ChangeXView.alloc.initWithDiameter(diameter, top: top), :change_x).on(:tap) do
      puts "tapped X"
    end
  end

  def drawLineSegmentAtX(x, withWidth: width)
    rmq(self).append(UIView, :hexagram_line_segment).style do |st|
      st.frame = { l: x, h: self.frame.size.height, t: 0, w: width }
    end
  end
end
