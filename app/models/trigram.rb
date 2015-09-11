class Trigram
  attr_accessor :chinese_name, :english_name, :characters, :binary, :number

  def self.load_async(&block)
    Api.get_all_trigrams(&block)
  end

  def self.find(number)
    Turnkey.unarchive("trigram-#{number}")
  end

  def self.from_json(params)
    Trigram.new.tap do |trigram|
      trigram.chinese_name = params["chinese_name"]
      trigram.english_name = params["english_name"]
      trigram.characters = params["characters"]
      trigram.binary = params["binary"]
      trigram.number = params["number"]
    end
  end
end
