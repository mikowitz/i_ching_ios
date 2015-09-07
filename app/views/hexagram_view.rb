class HexagramView < UIView
  attr_accessor :hexagram, :dim

  def draw_hexagram(size=20)
    @dim = self.frame.size.height / 24
    [1, 5, 9, 13, 17, 21].map { |i| i * dim }.each_with_index do |y, index|
      line = hexagram_lines[index]
      if line == 1
        rmq(self).append(UIView, :hexagram_line).style do |st|
          st.frame = { t: y, h: dim * 2, w: self.frame.size.width - dim * 2, l: dim }
        end
      else
        rmq(self).append(UIView, :hexagram_line).style do |st|
          st.frame = { t: y, h: dim * 2, w: dim * 7, l: dim }
        end
        rmq(self).append(UIView, :hexagram_line).style do |st|
          st.frame = { t: y, h: dim * 2, w: dim * 7, fr: dim }
        end
      end
    end
    rmq(self).on(:long_press) do
      highlight_hexagram
    end

    rmq(self).on(:pan) do |_, event|
      position_highlighter(event.location.y)
      if event.recognizer.state == UIGestureRecognizerStateEnded
        draw_highlighter(event)
      end
    end
  end

  def draw_highlighter(event)
    possible_centers = [6, 10, 14, 18].map {|i| dim * i }
    y = event.location.y
    actual_center = possible_centers.sort_by { |center| (center - y).abs }.first
    highlighter.animate(
      duration: 0.3,
      animations: -> (q) {
        position_highlighter(actual_center)
      }
    )
  end

  def highlighter
    @highlighter ||= rmq(self).append(UIView, :highlighter)
  end

  def position_highlighter(center)
    highlighter.style do |st|
      t = center - (dim * 6)
      if t < 0
        t = 0
      elsif t > dim * 12
        t = dim * 12
      end
      st.frame = { h: dim * 12, t: t }
    end
  end

  def highlight_hexagram
    highlighter.style do |st|
      st.frame = { t: 0, l: 0, w: st.superview.frame.size.width, h: st.superview.frame.size.height }
    end
  end

  def hexagram_lines
    hexagram.binary.split("").reverse.map(&:to_i)
  end
end
