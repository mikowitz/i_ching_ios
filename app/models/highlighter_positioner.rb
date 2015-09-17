class HighlighterPositioner
  attr_accessor :highlighter, :hexagram_view

  def initialize(highlighter)
    @highlighter = highlighter
  end

  def register_pan_gesture_recognizer
    rmq(hexagram_view).on(:pan) do |_, event|
      case event.recognizer.state
      when UIGestureRecognizerStateBegan
        if highlighter.frame.height == 0
          color_highlighter(rmq.color.clear)
          position_trigram_highlight(event)
          animate { color_highlighter(rmq.color.highlighter) }
        else
          animate { position_trigram_highlight(event) }
        end
      when UIGestureRecognizerStateEnded
        draw_highlighter(event)
      else
        position_trigram_highlight(event)
      end
    end
  end

  def register_long_press_gesture_recognizer
    rmq(hexagram_view).on(:long_press) {highlight_hexagram }
  end

  def position_trigram_highlight(event)
    position_highlighter(event.location.y)
  end

  def color_highlighter(color)
    highlighter.style { |st| st.background_color = color }
  end

  def frame_highlighter(frame)
    highlighter.style { |st| st.frame = frame }
  end

  def highlight_hexagram
    if highlighter.frame.height == 0
      frame_highlighter(h: hexagram_view.frame.size.height, t: 0)
      color_highlighter(rmq.color.clear)
      animate { color_highlighter(rmq.color.highlighter) }
    else
      animate { frame_highlighter(h: hexagram_view.frame.size.height, t: 0) }
    end
  end

  def draw_highlighter(event)
    y = event.location.y
    actual_center = possible_highlighter_centers.sort_by { |center| (center - y).abs }.first
    animate do
      position_highlighter(actual_center)
    end
  end

  def possible_highlighter_centers
    hexagram_view.possible_highlighter_centers
  end

  def animate(&block)
    highlighter.animate(duration: 0.5, animations: block)
  end

  def calculate_trigram_highlighter_frame(center)
    height = hexagram_view.dim * 12
    t = center - height / 2
    if t <= 0
      t = 0
    elsif t >= height
      t = height
    end
    { h: height, t: t }
  end

  def position_highlighter(center)
    frame_highlighter(calculate_trigram_highlighter_frame(center))
  end
end
