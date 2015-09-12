# -*- coding: utf-8 -*-
$:.unshift('/Library/RubyMotion/lib')
require 'motion/project/template/ios'

require "motion-require"
Motion::Require.all

require 'bundler'
Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings

  app.name = config["app_name"]
  app.identifier = config["app_identifier"]

  app.short_version = '0.1.0'
  # Get version from git
  #app.version = (`git rev-list HEAD --count`.strip.to_i).to_s
  app.version = app.short_version

  # RubyMotion by default selects the latest SDK you have installed,
  # if you would like to specify the SDK to assure consistency across multiple machines,
  # you can do so like the following examples
  # app.sdk_version = '8.3'
  # app.sdk_version = '7.1'

  # Target OS
  app.deployment_target = '7.1'
  # app.deployment_target = '8.0'

  app.icons = Dir.glob("resources/icon*.png").map{|icon| icon.split("/").last}

  app.device_family = [:iphone, :ipad]
  app.interface_orientations = [:portrait, :landscape_left, :landscape_right, :portrait_upside_down]

  app.files += Dir.glob(File.join(app.project_dir, 'lib/**/*.rb'))
  app.files += Dir.glob(File.join(app.project_dir, 'shared/**/*.rb'))
  app.files += Dir.glob(File.join(app.project_dir, 'models/**/*.rb'))

  # app.fonts = ['Oswald-Regular.ttf', 'FontAwesome.otf'] # These go in /resources
  # Or use all *.ttf fonts in the /resources/fonts directory:
  # app.fonts = Dir.glob("resources/fonts/*.ttf").map{|font| "fonts/#{font.split('/').last}"}
  # app.frameworks += %w(QuartzCore CoreGraphics MediaPlayer MessageUI CoreData)

  # app.vendor_project('vendor/Flurry', :static)
  # app.vendor_project('vendor/DSLCalendarView', :static, :cflags => '-fobjc-arc') # Using arc

  app.pods do
    # pod 'SDWebImage'
  #   pod 'JGProgressHUD'
  #   pod 'SVProgressHUD'
  #   pod "FontasticIcons"
  end

  app.info_plist['UIViewControllerBasedStatusBarAppearance'] = false
  app.status_bar_style = :light_content

  app.development do
    app.codesign_certificate = "iPhone Developer: YOURNAME"
    app.provisioning_profile = "signing/i_ching_ios.mobileprovision"
  end

  app.release do
    app.entitlements['get-task-allow'] = false
    app.codesign_certificate = 'iPhone Distribution: YOURNAME'
    app.provisioning_profile = "signing/i_ching_ios.mobileprovision"
    app.entitlements['beta-reports-active'] = true # For TestFlight

    app.seed_id = "YOUR_SEED_ID"
    app.entitlements['application-identifier'] = app.seed_id + '.' + app.identifier
    app.entitlements['keychain-access-groups'] = [ app.seed_id + '.' + app.identifier ]
  end
  puts "Name: #{app.name}"

  puts "Using profile: #{app.provisioning_profile}"
  puts "Using certificate: #{app.codesign_certificate}"
end

def config
  YAML.load(File.read("./config/environments/#{ENV["ENV"]}.yml"))
end
