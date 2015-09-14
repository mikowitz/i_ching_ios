class ChangeCircleView < UIView
  def initWithDiameter(diameter, top: top)
    self.initWithFrame(CGRectMake(0, top, diameter, diameter))
    self.layer.cornerRadius = diameter / 2.0
    self
  end

  def highlight
    rmq(:change_circle).style do |st|
      st.border_color = rmq.color.old_marker.CGColor
    end
    rmq(:change_x_line).style do |st|
      st.background_color = rmq.color.old_marker
    end
    rmq(self).style do |st|
      st.border_color = rmq.color.old_marker_highlighted.CGColor
    end
  end
end
