class HexagramTableScreen < PM::TableScreen
  title "Hexagrams"

  def on_load
    rmq.stylesheet = HexagramTableScreenStylesheet
    rmq(self.view).apply_style(:root_view)
    @hexagrams = {}
    load_async
  end

  def load_async
    Hexagram.load_async do |hexagrams|
      hexagrams.each do |(king_wen, hexagram)|
        @hexagrams[king_wen.to_i] = hexagram
      end
      Turnkey.archive(@hexagrams, "hexagrams")
      update_table_data
    end
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
