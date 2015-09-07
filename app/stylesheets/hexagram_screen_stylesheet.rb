class HexagramScreenStylesheet < ApplicationStylesheet
  def root_view(st)
    st.background_color = color.off_white
  end

  def hexagram_view(st)
    st.frame = { w: 240, t: 100, fr: 20 }
    st.background_color = color.off_white
  end

  def hexagram_english_name(st)
    st.frame = { fb: 100, h: 30, w: screen_width, centered: :horizontal }
    st.font = font.system(24)
    st.text_alignment = :center
    st.color = color.off_black
  end

  def hexagram_english_subtitle(st)
    st.frame = { fb: 50, h: 30, w: screen_width, centered: :horizontal }
    st.font = font.system(18)
    st.text_alignment = :center
    st.color = color.off_black
  end

  def hexagram_line(st)
    st.frame = { l: 0, t: 0, w: st.superview.frame.size.width, h: 20 }
    st.background_color = rmq.color.off_black
    st.layer.cornerRadius = 4
    st.layer.masksToBounds = true
  end
end
