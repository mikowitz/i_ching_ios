class CastHexagramScreen < PM::Screen
  attr_accessor :lines, :stabilized

  def on_load
    rmq.stylesheet = CastingScreenStylesheet
    rmq(self.view).apply_style(:root_view)
    rmq(self.view).tap do |q|
      q.append!(HexagramView, :hexagram_view).tap do |hexagram_view|
        hexagram_view.lines = lines
      end.draw_lines
    end
    self.title = Hexagram.find(stabilized).chinese_name
  end
end
