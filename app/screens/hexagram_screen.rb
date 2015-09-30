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
      @content_switcher = q.append!(ContentSwitcher, :content_switcher).tap do |content_switcher|
        content_switcher.data_source = self
      end
    end
    setup_content
  end

  def setup_content
    draw_english_name
    draw_chinese_characters
    @hexagram_view.draw_hexagram
    @content_switcher.setup_content
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
      q.append(UILabel, :hexagram_english_name).style do |st|
        st.text = hexagram.english_name
        st.resize_to_fit_text
        st.frame = { t: 79, centered: :horizontal }
      end
      if hexagram.english_subtitle
        q.append(UILabel, :hexagram_english_subtitle).style do |st|
          st.text = hexagram.english_subtitle
          st.resize_to_fit_text
          st.frame = { below_prev: 5, centered: :horizontal }
        end
      end
    end
  end

  # content switcher data source

  def content_keys
    [:judgement, :image]
  end

  def content_switcher(_, header_for_content_key: key)
    {
      judgement: "THE JUDGEMENT",
      image: "THE IMAGE"
    }.fetch(key)
  end

  def content_switcher(_, content_for_content_key: key)
    hexagram.send(key)
  end

end
