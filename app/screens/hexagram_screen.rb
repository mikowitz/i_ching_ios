# coding: utf-8
class HexagramScreen < PM::Screen
  attr_accessor :hexagram

  def on_load
    rmq.stylesheet = HexagramScreenStylesheet

    rmq(self.view).apply_style(:root_view)

    self.title = hexagram.chinese_name + " " + hexagram.characters

    rmq(self.view).tap do |q|
      q.append!(HexagramView, :hexagram_view).tap do |hexagram_view|
        hexagram_view.hexagram = hexagram
      end.draw_hexagram
    end
    draw_english_name
  end

  def draw_english_name
    rmq(self.view).tap do |q|
      q.append!(UILabel, :hexagram_english_name).tap do |label|
        label.text = hexagram.english_name
      end
      if hexagram.english_subtitle
        q.append!(UILabel, :hexagram_english_subtitle).tap do |label|
          label.text = hexagram.english_subtitle
        end
      end
    end
  end
end
