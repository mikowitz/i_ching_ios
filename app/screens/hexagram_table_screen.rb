class HexagramTableScreen < PM::TableScreen
  title "Hexagrams"

  def on_load
    rmq.stylesheet = HexagramTableScreenStylesheet
    rmq(self.view).apply_style(:root_view)
    @indices = (1..64).to_a
  end

  def table_data
    [
      {
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
          if hexagram = Hexagram.find(index)
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
        end.compact
      }
    ]
  end

  def show_hexagram(args={})
    hexagram = args[:hexagram]
    open HexagramScreen.new(nav_bar: true, hexagram: hexagram)
  end

  def present_casting_options
    alert = CastingOptionsAlert.new.tap do |alert|
      alert.delegate = self
      alert.wire_alert
    end

    presentViewController(alert.controller,
                          animated: true,
                          completion: nil)
  end

  def cast_hexagram(method)
    Proc.new { |_|
      Api.cast_hexagram(method) do |res|
        open CastingScreen.new(nav_bar: true, lines: res["lines"], stabilized: res["stabilized"], changed: res["changed"])
      end
    }.weak!
  end
end
