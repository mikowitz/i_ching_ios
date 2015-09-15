class HexagramTableScreen < PM::TableScreen
  title "Hexagrams"

  def on_load
    rmq.stylesheet = HexagramTableScreenStylesheet
    rmq(self.view).apply_style(:root_view)
    @indices = Turnkey.unarchive("hexagram-indices")
  end

  def table_data
    [
      {
        title: "Cast hexagram",
        title_view_height: 50,
        cells: [{
           title: "Cast hexagram",
           action: :present_casting_options
         }]
      },
      {
        title: "Hexagrams",
        title_view_height: 50,
        cells: @indices.sort.map do |index|
          hexagram = Hexagram.find(index)
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
      }
    ]
  end

  def show_hexagram(args={})
    hexagram = args[:hexagram]
    open HexagramScreen.new(nav_bar: true, hexagram: hexagram)
  end

  def present_casting_options
    alert = CastingOptionsAlert.new
    presentViewController(
      CastingOptionsAlert.instance.controller,
      animated: true,
      completion: nil
    )
  end
end
