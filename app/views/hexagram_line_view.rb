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
    if line == 0
      drawLineSegmentAtX(0, withWidth: dim * 7)
      drawLineSegmentAtX(dim * 11, withWidth: dim * 7)
    else
      drawLineSegmentAtX(0, withWidth: self.frame.size.width)
    end
  end

  def drawLineSegmentAtX(x, withWidth: width)
    rmq(self).append(UIView, :hexagram_line_segment).style do |st|
      st.frame = { l: x, h: self.frame.size.height, t: 0, w: width }
    end
  end
end
