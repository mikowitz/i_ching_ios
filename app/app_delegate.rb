class AppDelegate < PM::Delegate
  status_bar true, animation: :fade

  def on_load(app, options)
    StandardAppearance.apply(self.window)

    Hexagram.load_async do |hexagrams|
      @hexagrams = {}
      hexagrams.each do |(king_wen, hexagram)|
        @hexagrams[king_wen.to_i] = hexagram
      end
      Turnkey.archive(@hexagrams, "hexagrams")
      open HexagramTableScreen.new(nav_bar: true)
    end
  end

  # remove this if you are only supporting portrait
  def application(application, willchangestatusbarorientation: new_orientation, duration: duration)
    # manually set rmq's orientation before the device is actually oriented
    # so that we can do stuff like style views before the rotation begins
    device.orientation = new_orientation
  end
end
