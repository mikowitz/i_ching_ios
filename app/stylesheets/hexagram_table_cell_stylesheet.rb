class HexagramTableCellStylesheet < ApplicationStylesheet
  def number_label_width
    80
  end

  def number_label(st)
    st.font = font.system(40)
    st.frame = {
      l: 10,
      h: 30,
      w: number_label_width,
      centered: :vertical
    }
  end

  def chinese_label(st)
    st.font = font.system(30)
    st.frame = { l: number_label_width, t: 5, h: 40, w: st.superview.frame.size.width - number_label_width }
  end

  def english_label(st)
    st.font = font.system(15)
    st.frame = { l: number_label_width, fb: 5, h: 20, w: st.superview.frame.size.width - number_label_width }
  end
end
