class HexagramScreenStylesheet < ApplicationStylesheet
  include ContentSwitcherStylesheet

  def root_view(st)
    st.background_color = color.off_white
  end

  def highlighter(st)
    st.background_color = color.highlighter
    st.layer.cornerRadius = 4
    st.layer.masksToBounds = true
    st.z_position = -10
    st.frame = { w: st.superview.frame.size.width }
  end

  def hexagram_view(st)
    st.frame = "d2:l11"
    st.background_color = color.off_white
  end

  def hexagram_english_name(st)
    st.font = font.standard_at_size(18)
    st.text_alignment = :center
    st.color = color.off_black
  end

  def hexagram_english_subtitle(st)
    st.font = font.standard_at_size(12)
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
    st.frame = "a2:c4"
    character(st)
  end

  def character_1(st)
    st.frame = { grid: "a5:c7", below_prev: 0 }
    character(st)
  end

  def character(st)
    st.font = font.standard_at_size(80)
    st.color = color.off_black
    st.text_alignment = :center
  end

  def judgement(st)
    st.frame = { fb: 10, w: st.superview.frame.size.width - 30, h: 180, l: 15 }
    st.number_of_lines = 0
    st.line_break_mode = NSLineBreakByWordWrapping
    st.font = font.small_15
    st.color = color.off_black
  end

  def image(st)
    st.frame = { fb: 10, w: st.superview.frame.size.width - 30, h: 180, l: 15 }
    st.number_of_lines = 0
    st.line_break_mode = NSLineBreakByWordWrapping
    st.font = font.small_15
    st.color = color.off_black
    st.layer.opacity = 0.0
  end

  def judgement_header(st)
    st.color = color.off_black
    st.text = "THE JUDGEMENT"
    st.font = font.small
    st.resize_to_fit_text
    st.frame = { t: 465, l: 15, h: 30 }
  end

  def image_header(st)
    st.color = color.off_black
    st.layer.opacity = 0.2
    st.text = "THE IMAGE"
    st.font = font.small
    st.text_alignment = :right
    st.resize_to_fit_text
    st.frame = { t: 465, fr: 15, h: 30 }
  end

  def header_highlighter(st)
    st.background_color = color.highlighter
    st.layer.cornerRadius = 4
    st.layer.masksToBounds = true
    st.z_position = -10
  end

  def content_switcher(st)
    st.frame = { fb: 15, below_prev: 15, l: 15, w: st.superview.frame.size.width - 30 }
    st.background_color = color.clear
  end
end
