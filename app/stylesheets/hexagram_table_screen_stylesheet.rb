class HexagramTableScreenStylesheet < ApplicationStylesheet
  def hexagram_cell_height
    60
  end

  def root_view(st)
    st.background_color = color.off_white
  end
end
