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
    open HexagramScreen.new(nav_bar: true, hexagram: args[:hexagram])
  end

  # def tableView(table_view, didSelectRowAtIndexPath: index_path)
  #   cell = table_view.cellForRowAtIndexPath(index_path)
  #   cell.color(rmq.color.off_black, rmq.color.off_white)
  #   super
  # end

  # # def tableView(table_view, didDeselectRowAtIndexPath: index_path)
  # #   cell = table_view.cellForRowAtIndexPath(index_path)
  # #   cell.color(rmq.color.off_white, rmq.color.off_black)
  # #   super
  # # end
end
