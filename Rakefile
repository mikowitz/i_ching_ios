# -*- coding: utf-8 -*-
$:.unshift('/Library/RubyMotion/lib')
require 'motion/project/template/ios'

require "motion-require"
Motion::Require.all

require 'bundler'
Bundler.require

ENV["ENV"] ||= "development"

Dir.glob("lib/tasks/*.rake").each { |r| import r }

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
  # app.sdk_version = '8.4'

  # Target OS
  app.deployment_target = '8.4'
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
  app.vendor_project("vendor/UIAlertController", :static)

  app.pods do
    pod "AFNetworking", "~> 2.5.0"
  #   pod 'SDWebImage'
  #   pod 'JGProgressHUD'
  #   pod 'SVProgressHUD'
  #   pod "FontasticIcons"
  end

  app.info_plist["NSAppTransportSecurity"] = {
    "NSAllowsArbitraryLoads" => true
  }

  app.info_plist['UIViewControllerBasedStatusBarAppearance'] = false
  app.status_bar_style = :light_content

  app.development do
    app.codesign_certificate = "iPhone Developer: Michael Berkowitz (M7G2ZHUWSD)"
    app.provisioning_profile = "/Users/michaelberkowitz/provisioning_profiles/IChing_Dev.mobileprovision"
  end

  app.release do
    app.entitlements['get-task-allow'] = false
    app.codesign_certificate = "iPhone Distribution: Michael Berkowitz (DBJ4K93CJ6)"
    app.provisioning_profile = "/Users/michaelberkowitz/provisioning_profiles/IChing_AdHoc.mobileprovision"
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
