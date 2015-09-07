class HexagramTableScreen < PM::TableScreen
  title "Hexagrams"

  def on_load
    rmq.stylesheet = HexagramTableScreenStylesheet
    rmq(self.view).apply_style(:root_view)
    @hexagrams = Turnkey.unarchive("hexagrams")
  end

  def table_data
    [{
      cells: @hexagrams.sort_by(&:first).map do |(_, hexagram)|
        {
          cell_class: HexagramTableCell,
          action: :show_hexagram,
          arguments: {
            hexagram: hexagram
          },
          style: {
            hexagram: hexagram
          }
        }
      end
    }]
  end

  def show_hexagram(args={})
    hexagram = Hexagram.new(args[:hexagram])
    open HexagramScreen.new(nav_bar: true, hexagram: hexagram)
  end
end
