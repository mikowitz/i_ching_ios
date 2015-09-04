class HexagramTableCellStylesheet < ApplicationStylesheet
  def left_margin
    20
  end

  def number_label_width
    52
  end

  def hexagram_table_cell(st)
    st.background_color = color.off_white
  end

  def number_label(st)
    st.font = font.system(36)
    st.color = color.off_black
    st.text_alignment = :right
    st.frame = {
      l: left_margin,
      w: number_label_width,
      h: 38,
      centered: :vertical
    }
  end

  def chinese_label(st)
    st.font = font.system(20)
    st.color = color.off_black
    st.frame = { l: left_margin + number_label_width + 10, t: 3, h: 30, w: st.superview.frame.size.width - number_label_width }
  end

  def english_label(st)
    st.font = font.system(10)
    st.color = color.off_black
    st.frame = { l: left_margin + number_label_width + 10, fb: 3, h: 14, w: st.superview.frame.size.width - number_label_width }
  end
end
