class AppDelegate < PM::Delegate
  status_bar true, animation: :fade

  def on_load(app, options)
    open HexagramTableScreen.new(nav_bar: true)
  end

  # remove this if you are only supporting portrait
  def application(application, willchangestatusbarorientation: new_orientation, duration: duration)
    # manually set rmq's orientation before the device is actually oriented
    # so that we can do stuff like style views before the rotation begins
    device.orientation = new_orientation
  end
end
