class HexagramTableCell < PM::TableViewCell
  attr_accessor :hexagram

  def rmq_build
    rmq.stylesheet = HexagramTableCellStylesheet
    rmq(self).tap do |q|
      @number_label = q.append!(UILabel, :number_label)
      @chinese_label = q.append!(UILabel, :chinese_label)
      @english_label = q.append!(UILabel, :english_label)
    end
  end

  def hexagram=(hexagram)
    @number_label.text = hexagram["king_wen_number"].to_s + "."
    @chinese_label.text = hexagram["names"]["chinese"]
    @english_label.text = hexagram["names"]["english"]
    rmq(self).all.reapply_styles
  end
end
