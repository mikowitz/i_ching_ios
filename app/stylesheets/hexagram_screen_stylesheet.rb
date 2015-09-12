class HexagramScreenStylesheet < ApplicationStylesheet
  def root_view(st)
    st.background_color = color.off_white
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
    st.background_color = color.white
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


  def character_0(st)
    st.frame = "a1:c3"
    character(st)
  end

  def character_1(st)
    st.frame = "a4:c6"
    character(st)
  end

  def character(st)
    st.font = font.font_with_name("STHeitiSC-Medium", 50)
    st.color = color.off_black
    st.text_alignment = :center
  end
end
