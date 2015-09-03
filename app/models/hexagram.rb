class Hexagram
  def self.load_async
    Api.get_all_hexagrams
    yield
  end
end
