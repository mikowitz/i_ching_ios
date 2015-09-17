class HighlighterPositioner
  attr_reader :highlighter

  def initialize(highlighter)
    @highlighter = highlighter
  end

  def position_highlighter(center, height)
    highlighter.style do |st|
      t = center - height / 2
      if t <= 0
        t = 0
      elsif t >= height
        t = height
      end
      st.frame = { h: height, t: t }
    end
  end

  def highlight_hexagram
    if highlighter.frame.height == 0
      frame_highlighter(h: highlighter.superview.frame.size.height, t: 0)
      color_highlighter(rmq.color.clear)
      highlighter.animate(
        duration: 0.5,
        animations: -> (q) {
          color_highlighter(rmq.color.highlighter)
        }
      )
    else
      highlighter.animate(
        duration: 0.5,
        animations: -> (q) {
          frame_highlighter(h: highlighter.superview.frame.size.height, t: 0)
        }
      )
    end
  end

  def draw_highlighter(event)
    y = event.location.y
    actual_center = possible_highlighter_centers.sort_by { |center| (center - y).abs }.first
    highlighter.animate(
      duration: 0.3,
      animations: -> (q) {
        position_highlighter(actual_center, highlighter.superview.get.dim * 12)
      }
    )
  end

  def possible_highlighter_centers
    highlighter.superview.get.possible_highlighter_centers
  end

  def register_pan_gesture_recognizer(view)
    rmq(view).on(:pan) do |_, event|
      if event.recognizer.state == UIGestureRecognizerStateBegan
        if highlighter.frame.height == 0
          color_highlighter(rmq.color.clear)
          position_trigram_highlight(event)
          highlighter.animate(
            duration: 0.5,
            animations: -> (q) {
              color_highlighter(rmq.color.highlighter)
            }
          )
        else
          highlighter.animate(
            duration: 0.5,
            animations: -> (q) {
              position_trigram_highlight(event)
            }
          )
        end
      elsif event.recognizer.state == UIGestureRecognizerStateEnded
        draw_highlighter(event)
      else
        position_trigram_highlight(event)
      end
    end
  end

  def register_long_press_gesture_recognizer(view)
    rmq(view).on(:long_press) do
      highlight_hexagram
    end
  end

  def position_trigram_highlight(event)
    position_highlighter(event.location.y, highlighter.superview.get.dim * 12)
  end

  def color_highlighter(color)
    highlighter.style do |st|
      st.background_color = color
    end
  end

  def frame_highlighter(frame)
    highlighter.style do |st|
      st.frame = frame
    end
  end
end
