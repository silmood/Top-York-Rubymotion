# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/android'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'TopYork'
  app.api_version = "17"
  app.archs = ["x86"] unless ARGV.include?("device") || ARGV.include?("release")
  app.support_libraries << 'android-support-v7-appcompat'
  app.support_libraries << 'android-support-v7-cardview'
  app.support_libraries << 'android-support-v7-recyclerview'

  app.theme = '@style/AppTheme'
  #Gradle dependencies using motion-gradle. Use rake gradle:install
  app.gradle do
    dependency 'com.squareup.okhttp:okhttp:2.4.0'
  end
end
