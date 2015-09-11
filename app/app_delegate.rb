class AppDelegate < PM::Delegate
  status_bar true, animation: :fade

  def on_load(app, options)
    StandardAppearance.apply(self.window)

    Hexagram.load_async do |hexagrams|
      @hexagrams = {}
      @hexagram_indices = []
      hexagrams.each do |hexagram_json
        hexagram = Hexagram.from_json(hexagram_json)
        Turnkey.archive(hexagram, "hexagram-#{hexagram.king_wen_number}")
        @hexagram_indices << hexagram.king_wen_number
      end
      Turnkey.archive(@hexagram_indices, "hexagram-indices")
      open HexagramTableScreen.new(nav_bar: true)
    end
  end
end
