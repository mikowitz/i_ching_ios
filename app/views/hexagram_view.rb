class HexagramView < UIView
  attr_accessor :hexagram

  def draw_hexagram(size=22)
    6.times.map { |i| i * size * 2 }.each do |y|
      rmq(self).append(UIView, :hexagram_line).style do |st|
        st.frame = { t: y, h: size }
      end
    end
    rmq(self).style { |st| st.frame = { h: size * 11 } }
  end
end
