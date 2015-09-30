class HexagramView < UIView
  attr_accessor :hexagram, :lines, :delegate

  def dim
    @dim ||= self.frame.size.height / 24
  end

  def line_positions
    @line_positions ||= [21, 17, 13, 9, 5, 1].map { |i| i * dim }
  end

  def possible_highlighter_centers
    @possible_highlighter_centers ||= [6, 10, 14 , 18].map { |i| i * dim }
  end

  def draw_lines
    line_positions.each_with_index do |y, index|
      line = lines[index]
      rmq(self).append!(HexagramLineView, :hexagram_line).tap do |hexagram_line|
        hexagram_line.styleForLine(line, atY: y, index: index)
      end
    end
  end

  def draw_hexagram(size=20)
    line_positions.each_with_index do |y, index|
      line = hexagram_lines[index]
      rmq(self).append!(HexagramLineView, :hexagram_line).tap do |hexagram_line|
        hexagram_line.styleForLine(line, atY: y)
      end
    end
    positioner.register_long_press_gesture_recognizer
    positioner.register_pan_gesture_recognizer
    self
  end

  def draw_highlighter(event)
    positioner.draw_highlighter(event)
  end

  def highlighter
    @highlighter ||= rmq(self).append(UIView, :highlighter)
  end

  def positioner
    @positioner ||= HighlighterPositioner.new(highlighter).tap do |positioner|
      positioner.hexagram_view = self
    end
  end

  def position_highlighter(center)
    positioner.position_highlighter(center, dim * 12)
  end

  def highlight_hexagram
    positioner.highlight_hexagram
  end

  def hexagram_lines
    hexagram.binary.split("").map(&:to_i)
  end
end
