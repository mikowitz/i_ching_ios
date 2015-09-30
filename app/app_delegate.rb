class AppDelegate < PM::Delegate
  status_bar true, animation: :fade

  def on_load(app, options)
    StandardAppearance.apply(self.window)

    load_data
    true
  end

  def load_data
    Trigram.load_async do |trigrams|
      trigrams.each do |trigram_json|
        trigram = Trigram.from_json(trigram_json)
        Turnkey.archive(trigram, "trigram-#{trigram.number}")
      end
      Hexagram.load_async do |hexagrams|
        hexagrams.each do |hexagram_json|
          hexagram = Hexagram.from_json(hexagram_json)
          Turnkey.archive(hexagram, "hexagram-#{hexagram.king_wen_number}")
        end
        Turnkey.archive(Settings.api_current_version, "latest-api-version")
        open HexagramTableScreen.new(nav_bar: true)
      end
    end
  end
end
