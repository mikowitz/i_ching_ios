class ChangeXView < UIView
  def initWithDiameter(diameter, top: top)
    self.initWithFrame(CGRectMake(0, top, diameter, diameter))
    self.layer.cornerRadius = diameter / 2.0
    self.drawX
    self
  end

  def drawX
    rmq(self).tap do |q|
      q.append!(UIView, :change_x_line).transform = CGAffineTransformMakeRotation(-45 * Math::PI / 180)
      q.append!(UIView, :change_x_line).transform = CGAffineTransformMakeRotation(45 * Math::PI / 180)
    end
  end
end
