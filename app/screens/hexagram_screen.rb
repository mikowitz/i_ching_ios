class HexagramScreen < PM::Screen
  attr_accessor :hexagram

  def on_load
    rmq.stylesheet = HexagramScreenStylesheet

    rmq(self.view).apply_style(:root_view)

    self.title = hexagram["names"]["chinese"]
  end
end
