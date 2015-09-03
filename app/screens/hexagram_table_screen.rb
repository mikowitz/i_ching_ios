class HexagramTableScreen < PM::TableScreen
  title "Hexagrams"

  def on_load
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
    puts args[:hexagram]["names"]["english"]
  end

  def tableView(_, heightForRowAtIndexPath:_)
    60
  end
end
