namespace :appium do
  desc 'Prepare to run integration tests'
  task :prepare do
    ENV['ENV'] = "integration"
    Rake::Task["clean:all"].invoke
    Motion::Project::App.setup do |app|
      app.files += Dir.glob(File.join(app.project_dir, "features/concerns/*.rb"))
      app.pods do
        pod 'SimulatorStatusMagic'
      end
    end
    Rake::Task["pod:install"].invoke
    Rake::Task["build:simulator"].invoke

    # we have a pod thats for integration only we dont want to mess with the podfile.lock
    system "git checkout vendor/Podfile.lock"
  end
end
