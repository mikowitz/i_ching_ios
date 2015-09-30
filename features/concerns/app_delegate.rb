class AppDelegate
  def load_data
    SDStatusBarManager.sharedInstance.enableOverrides
    SDStatusBarManager.sharedInstance.timeString = "2:00 PM"

    hexagram = Hexagram.from_json(
      "chinese_name" => "Chinese Name",
      "english_name" => "English Name (English Subtitle)",
      "characters" => "@",
      "binary" => "010101",
      "king_wen_number" => 1,
      "judgement" => "I judge you\nPikachu!",
      "image" => "Hold your head up\nbuddy!"
    )
    Turnkey.archive(hexagram, "hexagram-1")

    open HexagramTableScreen.new(nav_bar: true)
  end
end
