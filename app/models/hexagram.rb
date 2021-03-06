class Hexagram
  attr_accessor :chinese_name, :english_name, :characters, :english_subtitle,
                :binary, :king_wen_number, :judgement, :image

  def self.load_async(&block)
    Api.get_all_hexagrams(&block)
  end

  def self.find(king_wen_number)
    Turnkey.unarchive("hexagram-#{king_wen_number}")
  end

  def self.from_json(params)
    Hexagram.new.tap do |hexagram|
      hexagram.chinese_name = params["chinese_name"]
      hexagram.english_name, hexagram.english_subtitle = Hexagram.build_english_names(params["english_name"])
      hexagram.characters = params["characters"]
      hexagram.binary = params["binary"]
      hexagram.king_wen_number = params["king_wen_number"]
      hexagram.judgement = params["judgement"]
      hexagram.image = params["image"]
    end
  end

  def self.build_english_names(english_name)
    names = english_name.scan(/^([^\(\[]+)(.*?)$/)[0].map(&:strip)
    names[1] == "" ? names[0] : names
  end
end
