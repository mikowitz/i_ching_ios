class HexagramTableScreen < PM::TableScreen
  title "Hexagrams"

  def on_load
    rmq.stylesheet = HexagramTableScreenStylesheet
    rmq(self.view).apply_style(:root_view)

    @hexagrams = []
    Hexagram.load_async do
      @hexagrams = Turnkey.unarchive("hexagrams")
      update_table_data
    end
  end

  def table_data
    [{
       cells: @hexagrams.keys.sort.map do |n|
         {
           cell_class: HexagramTableCell,
           action: :show_hexagram,
           arguments: {
             hexagram: @hexagrams[n]
           },
           style: {
             hexagram: @hexagrams[n]
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
