#
# Be sure to run `pod lib lint MaryTabBar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MaryTabBar'
  s.version          = '0.1.0'
  s.summary          = 'MaryTabBar is a light way to add customization with animation to your tab bar view'
  s.swift_version    = '5.0'
  

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
 MaryTabBar is a light way to add customization with animation to your tab bar view.
                       DESC

  s.homepage         = 'https://github.com/Babich-anton/MaryTabBar'
  
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'antosha.1998.ru@mail.ru' => 'babich.anton.q@gmail.com' }
  s.source           = { :git => 'https://github.com/Babich-anton/MaryTabBar.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '9.3'

  s.source_files = 'MaryTabBar/Classes/**/*'
  
end
