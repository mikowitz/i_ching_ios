class HexagramView < UIView
  attr_accessor :hexagram

  def draw_hexagram(size=20)
    dim = self.frame.size.height / 24
    [1, 5, 9, 13, 17, 21].map { |i| i * dim }.each do |y|
      rmq(self).append(UIView, :hexagram_line).style do |st|
        st.frame = { t: y, h: dim * 2, w: self.frame.size.width - dim * 2, l: dim }
      end
    end
  end
end
