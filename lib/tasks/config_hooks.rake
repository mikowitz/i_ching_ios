before :"build:simulator" do
  create_configuration
end

before :"build:device" do
  create_configuration
end

def create_configuration
  ENV["ENV"] = "development" if ENV["ENV"].nil?

  File.open("./app/settings.rb", "w") do |file|
    file.puts("class Settings")
    config.each do |k,v|
      file.puts("  def self.#{k}; \"#{v}\"; end")
    end
    file.puts("end")
  end

  Motion::Project::App.setup do |app|
    app.files += Dir.glob(File.join(app.project_dir, "app/settings.rb"))
  end
end

def config
  YAML.load(File.read("./config/environments/#{ENV["ENV"]}.yml"))
end
