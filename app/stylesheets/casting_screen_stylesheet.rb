# coding: utf-8
class CastingScreenStylesheet < ApplicationStylesheet
  def root_view(st)
    st.background_color = color.off_white
  end

  def change_circle(st)
    st.masks_to_bounds = true
    st.border_color = color(80, 80, 80).CGColor
    st.border_width = 8.0
    st.frame = { centered: :horizontal }
  end

  def change_x_line(st)
    st.background_color = color(80, 80, 80)
    st.frame = { w: 8, h: st.superview.size.height, t: 0, centered: :horizontal }
  end

  def change_x(st)
    st.background_color = color.clear
    st.frame = { centered: :horizontal }
  end

  def highlighter(st)
    st.background_color = color(hex: "6df", a: 0.5)
    st.layer.cornerRadius = 4
    st.layer.masksToBounds = true
    st.z_position = -10
    st.frame = { w: st.superview.frame.size.width }
  end

  def hexagram_view(st)
    st.frame = "d1:l10"
    st.background_color = color.off_white
  end

  def hexagram_english_name(st)
    st.frame = { grid: "a11:l", h: 35 }
    st.font = font.system(18)
    st.text_alignment = :center
    st.color = color.off_black
  end

  def hexagram_english_subtitle(st)
    st.frame = { grid: "a:l", below_prev: 5, h: 20 }
    st.font = font.system(12)
    st.text_alignment = :center
    st.color = color.off_black
  end

  def hexagram_line(st)
    rounded(st)
  end

  def hexagram_line_segment(st)
    st.background_color = rmq.color.off_black
    rounded(st)
  end
end
