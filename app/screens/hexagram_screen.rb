# coding: utf-8
class HexagramScreen < PM::Screen
  attr_accessor :hexagram

  def on_load
    rmq.stylesheet = HexagramScreenStylesheet

    rmq(self.view).apply_style(:root_view)

    self.title = hexagram.chinese_name

    rmq(self.view).tap do |q|
      @hexagram_view = q.append!(HexagramView, :hexagram_view).tap do |hexagram_view|
        hexagram_view.hexagram = hexagram
      end
      @hexagram_view.draw_hexagram
    end
    draw_english_name
    draw_chinese_characters
  end

  def on_disappear
    @hexagram_view.highlighter.style do |st|
      st.background_color = rmq.color.clear
      st.frame = { h: 0, t: 0 }
    end
  end

  def draw_chinese_characters
    characters = hexagram.characters.split("")
    characters.each_with_index do |char, index|
      append!(UILabel, :"character_#{index}").text = char
    end
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
