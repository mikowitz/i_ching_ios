class Hexagram
  attr_reader :chinese_name, :english_name, :characters, :english_subtitle

  def self.load_async(&block)
    Api.get_all_hexagrams(&block)
  end

  def initialize(params)
    @chinese_name = params["names"]["chinese"]["pinyin_accented"]
    @english_name, @english_subtitle = build_english_names(params["names"]["english"])
    @characters = params["names"]["chinese"]["characters"]
  end

  private

  def build_english_names(english_name)
    names = english_name.scan(/^([^\(\[]+)(.*?)$/)[0].map(&:strip)
    names[1] == "" ? names[0] : names
  end
end
