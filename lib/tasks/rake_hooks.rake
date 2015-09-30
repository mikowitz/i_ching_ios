task :"test_sweet:run" => :"appium:prepare"

before :"test_sweet:run" do
  ENV["ENV"] = "integration"
  ENV["device"] ||= "iPhone 5s"
end

before :"test_sweet" do
  ENV["ENV"] = "integration"
end
