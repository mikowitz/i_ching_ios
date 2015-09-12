class AppDelegate < PM::Delegate
  attr_accessor :carousel
  status_bar true, animation: :fade

  def on_load(app, options)
    StandardAppearance.apply(self.window)

    Trigram.load_async do |trigrams|
      trigrams.each do |trigram_json|
        trigram = Trigram.from_json(trigram_json)
        Turnkey.archive(trigram, "trigram-#{trigram.number}")
      end
      Hexagram.load_async do |hexagrams|
        @hexagram_indices = []
        hexagrams.each do |hexagram_json|
          hexagram = Hexagram.from_json(hexagram_json)
          Turnkey.archive(hexagram, "hexagram-#{hexagram.king_wen_number}")
          @hexagram_indices << hexagram.king_wen_number
        end
        Turnkey.archive(@hexagram_indices, "hexagram-indices")
        Api.cast_hexagram(:yarrow) do |result|
          open CastingScreen.new(nav_bar: true, lines: result["lines"].reverse, stabilized: result["stabilized"],
                                 changed: result["changed"])
        end
      end
    end
  end
end
