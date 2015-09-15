class CastingOptionsAlert
  attr_accessor :controller

  def self.instance
    Dispatch.once { @instance ||= new }
    @instance
  end

  def initialize
    @controller = alert_controller
    %w( Yarrow Coins Random ).each do |casting_method|
      add_action(casting_method)
    end
    add_cancel_action
    @controller
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
        handler: CastingOptionsAlert.cast_hexagram(casting_method.downcase)
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

  def self.cast_hexagram(method)
    Proc.new { |_|
      mp res
      # Api.cast_hexagram(method) do |res|
      #   mp res
      # end
    }.weak!
  end
end
