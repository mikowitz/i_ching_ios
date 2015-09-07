class HexagramTableCell < PM::TableViewCell
  attr_accessor :hexagram

  def rmq_build
    rmq.stylesheet = HexagramTableCellStylesheet
    rmq(self).apply_style(:hexagram_table_cell)
    rmq(self).tap do |q|
      @number_label = q.append!(UILabel, :number_label)
      @chinese_label = q.append!(UILabel, :chinese_label)
      @english_label = q.append!(UILabel, :english_label)
    end
    @chinese_label.highlightedTextColor = rmq.color.off_white
    @english_label.highlightedTextColor = rmq.color.off_white
    @number_label.highlightedTextColor = rmq.color.off_white
  end

  def hexagram=(hexagram)
    @number_label.text = hexagram["king_wen_number"].to_s + "."
    @chinese_label.text = hexagram["names"]["chinese"]["pinyin_accented"]
    @english_label.text = hexagram["names"]["english"]
    rmq(self).all.reapply_styles
  end

  def setSelected(selected, animated: animated)
    super
    bgView = UIView.alloc.initWithFrame(self.selectedBackgroundView.frame)
    bgView.setBackgroundColor(rmq.color.off_black)
    self.setSelectedBackgroundView(bgView)
  end
end
