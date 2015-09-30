module ContentSwitcherStylesheet
  def content_switcher(st)
    st.frame = { fb: 15, l: 15, w: st.superview.frame.size.width - 30, h: 200 }
    st.background_color = color.clear
  end

  def header_segmented_control(st)
    st.frame = { t: 0, l: 0, w: st.superview.frame.size.width, h: 30 }
  end

  def content(st)
    st.frame = { t: 40, w: st.superview.frame.size.width, fb: 0 }
    st.background_color = color.clear
    st.number_of_lines = 0
  end

  def header_highlighter(st)
    st.background_color = rmq.color.cyan
    st.layer.cornerRadius = 4
    st.layer.masksToBounds = true
    st.z_position = -10
  end
end
