class AppDelegate
  def load_data
    SDStatusBarManager.sharedInstance.enableOverrides
    SDStatusBarManager.sharedInstance.timeString = "2:00 PM"

    Hexagram.load_async do |hexagrams|
      hexagrams.each do |hexagram_json|
        hexagram = Hexagram.from_json(hexagram_json)
        Turnkey.archive(hexagram, "hexagram-#{hexagram.king_wen_number}")
      end
      open HexagramTableScreen.new(nav_bar: true)
    end
  end
end
