Given /^I start the app/ do
  # no-op
end

When /^I page (left|right)/ do |direction|
  dimensions = find_element(:xpath, "//UIAApplication[1]").size
  y = dimensions.height - 10
  if direction == "left"
    x = 30
  else
    x = dimensions.width - 30
  end
  Appium::TouchAction.new.press(x: x, y: y, fingers: 1, tapCount: 1, duration: 500).perform
end
