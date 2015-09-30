class RubyMotionQuery::Font
  STANDARD_FONT = "STHeitiSC-Medium"

  class << self
    def standard_at_size(size)
      UIFont.fontWithName(STANDARD_FONT, size: size)
    end

    def standard_medium
      @standard_medium ||= standard_at_size(20)
    end
  end
end

class ApplicationStylesheet < RubyMotionQuery::Stylesheet

  def application_setup

    # rmq.app.grid.tap do |g|
    #   g.num_columns =  18
    #   g.num_rows = 32
    #   g.column_gutter = 0
    #   g.row_gutter = 0
    #   g.content_left_margin = 0
    #   g.content_top_margin = 74
    #   g.content_right_margin = 0
    #   g.content_bottom_margin = 0
    # end

    # An example of setting standard fonts and colors
    font_family = "STHeitiSC-Medium"
    font.add_named :large,    font_family, 36
    font.add_named :medium,    font_family, 20
    font.add_named :small,    font_family, 20
    font.add_named :small_15,    font_family, 15
    # font.add_named :medium,   font_family, 24
    # font.add_named :small,    font_family, 18

    color.add_named :tint, '236EB7'
    color.add_named :translucent_black, color(0, 0, 0, 0.4)
    color.add_named :battleship_gray,   '#7F7F7F'
    color.add_named :off_black, color(10, 10, 10, 1.0)
    color.add_named :off_white, color(250, 250, 250, 1.0)
    color.add_named :old_marker, color(60, 60, 200, 1.0)
    color.add_named :old_marker_highlighted, color(60, 60, 255, 1.0)
    color.add_named :highlighter, color(hex: "6df", a: 0.5)
  end

  def rounded(st)
    st.corner_radius = 4
    st.masks_to_bounds = true
  end

  def bordered(st, color)
    st.border_color = color.CGColor
    st.border_width = 2.0
  end

  def standard_button(st)
    st.frame = {w: 40, h: 18}
    st.background_color = color.tint
    st.color = color.white
  end

  def standard_label(st)
    st.frame = {w: 40, h: 18}
    st.background_color = color.clear
    st.color = color.black
  end

  def paginator(st)
    st.background_color = color.off_white
  end
end
