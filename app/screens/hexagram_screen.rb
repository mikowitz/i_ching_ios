# coding: utf-8
class HexagramScreen < PM::Screen
  attr_accessor :hexagram

  def on_load
    rmq.stylesheet = HexagramScreenStylesheet

    rmq(self.view).apply_style(:root_view)

    self.title = hexagram["names"]["chinese"]["pinyin_accented"] +
                 " " + hexagram["names"]["chinese"]["characters"]

    rmq(self.view).tap do |q|
      q.append!(HexagramView, :hexagram_view).tap do |hexagram_view|
        hexagram_view.hexagram = hexagram
      end.draw_hexagram
    end
    draw_english_name
  end

  def draw_english_name
    name = hexagram["names"]["english"].scan(/^([^\(\[]+)(.*?)$/)[0]
    main_name = name[0].strip
    sub_name = name[1]
    rmq(self.view).tap do |q|
      q.append!(UILabel, :hexagram_english_name).tap do |label|
        label.text = main_name
      end
      if sub_name.length > 0
        q.append!(UILabel, :hexagram_english_subtitle).tap do |label|
          label.text = sub_name
        end
      end

    end
  end
end
