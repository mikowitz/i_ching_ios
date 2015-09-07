class HexagramView < UIView
  attr_accessor :hexagram

  def draw_hexagram(size=20)
    dim = self.frame.size.height / 24
    [1, 5, 9, 13, 17, 21].map { |i| i * dim }.each do |y|
      rmq(self).append(UIView, :hexagram_line).style do |st|
        st.frame = { t: y, h: dim * 2, w: self.frame.size.width - dim * 2, l: dim }
      end
    end
    # [1, 3, 5, 7, 9, 11].map { |i| i * size }.each do |y|
    #   rmq(self).append(UIView, :hexagram_line).style do |st|
    #     st.frame = { t: y, h: size, w: size * 11, l: size }
    #   end
    # end
    # dimension = size * 13
    # rmq(self).style { |st| st.frame = { fr: 15, w: dimension, h: dimension } }
  end
end
