module Api
  def self.cast_hexagram(_, &block)
    block.call({
                 "lines" => [6,7,8,9,7,6],
                 "stabilized" => 47,
                 "changed" => 61
               })
  end

  def self.get_all_hexagrams(&block)
    block.call([1, 47, 61].map { |n|
                 {
                   "chinese_name" => "Chinese Name #{n}",
                   "english_name" => "English Name #{n} (English Subtitle #{n})",
                   "characters" => "#{n}",
                   "binary" => test_binaries[n],
                   "king_wen_number" => n,
                   "judgement" => "Judgement #{n}",
                   "image" => "Image #{n}"
                 }
               })
  end

  def self.test_binaries
    {
      1 => "111111",
      47 => "010110",
      61 => "110011"
    }
  end

end
