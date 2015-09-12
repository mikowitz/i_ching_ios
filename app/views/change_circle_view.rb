class ChangeCircleView < UIView
  def initWithDiameter(diameter, top: top)
    self.initWithFrame(CGRectMake(0, top, diameter, diameter))
    self.layer.cornerRadius = diameter / 2.0
    self
  end
end
