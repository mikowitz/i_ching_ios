class HighlighterPositioner
  attr_accessor :highlighter, :hexagram_view

  def initialize(highlighter)
    @highlighter = highlighter
  end

  def position_highlighter(center, height)
    t = center - height / 2
    if t <= 0
      t = 0
    elsif t >= height
      t = height
    end
    frame_highlighter(h: height, t: t)
  end

  def highlight_hexagram
    if highlighter.frame.height == 0
      frame_highlighter(h: hexagram_view.frame.size.height, t: 0)
      color_highlighter(rmq.color.clear)
      animate do
        color_highlighter(rmq.color.highlighter)
      end
    else
      animate do
        frame_highlighter(h: hexagram_view.frame.size.height, t: 0)
      end
    end
  end

  def draw_highlighter(event)
    y = event.location.y
    actual_center = possible_highlighter_centers.sort_by { |center| (center - y).abs }.first
    animate do
      position_highlighter(actual_center, hexagram_view.dim * 12)
    end
  end

  def possible_highlighter_centers
    hexagram_view.possible_highlighter_centers
  end

  def animate(&block)
    highlighter.animate(duration: 0.5, animations: block)
  end

  def register_pan_gesture_recognizer(view)
    rmq(view).on(:pan) do |_, event|
      if event.recognizer.state == UIGestureRecognizerStateBegan
        if highlighter.frame.height == 0
          color_highlighter(rmq.color.clear)
          position_trigram_highlight(event)
          animate do
            color_highlighter(rmq.color.highlighter)
          end
        else
          animate do
            position_trigram_highlight(event)
          end
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
    position_highlighter(event.location.y, hexagram_view.dim * 12)
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
