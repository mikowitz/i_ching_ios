class CastingOptionsAlert
  attr_accessor :controller, :delegate

  def initialize
    @controller = alert_controller
  end

  def wire_alert
    %w( Yarrow Coins Random ).each do |casting_method|
      add_action(casting_method)
    end
    add_cancel_action
    self
  end

  def alert_controller
    UIAlertController.alertControllerWithTitle(
      "Casting Method",
      message: nil,
      preferredStyle: UIAlertControllerStyleActionSheet
    )
  end

  def add_action(casting_method)
    @controller.addAction(
      UIAlertAction.actionWithTitle(
        casting_method,
        style: UIAlertActionStyleDefault,
        handler: delegate.cast_hexagram(casting_method.downcase)
      )
    )
  end

  def add_cancel_action
    @controller.addAction(
      UIAlertAction.actionWithTitle(
        "Cancel",
        style: UIAlertActionStyleCancel,
        handler: nil
      )
    )
  end
end
