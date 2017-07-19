#
# Be sure to run `pod lib lint M4CoreFoundation.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'M4CoreFoundation'
  s.version          = '0.7.0'
  s.summary          = 'M4CoreFoundation use for company projects.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  M4CoreFoundation use for company projects.
                       DESC

  s.homepage         = 'https://github.com/Magic4Cloud/'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '270452746@qq.com' => '270452746@qq.com' }
  s.source           = { :git => 'https://github.com/Magic4Cloud/M4CoreFundations.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'M4CoreFoundation/ViewControllers/*.{h,m}', 'M4CoreFoundation/Utility/*.{h,m}',  'M4CoreFoundation/UIKit/*.{h,m}', 
                  'M4CoreFoundation/SNS/*.{h,m}', 'M4CoreFoundation/Notifications/*.{h,m}', 'M4CoreFoundation/Networking/*.{h,m}', 
                  'M4CoreFoundation/Macros/*.{h}', 'M4CoreFoundation/Foundation/*.{h,m}', 'M4CoreFoundation/Category/*.{h,m}', 
                  'M4CoreFoundation/BaseClass/*.{h,m}', 'M4CoreFoundation/*.{h}'

  s.frameworks = "UIKit", "Foundation", "WebKit", "QuartzCore", "MobileCoreServices"
  s.dependency 'MJRefresh'
  s.dependency 'AFNetworking' 
  s.dependency 'YYModel'
  s.dependency 'YYWebImage' 
  s.dependency 'YYCategories'
  
  # s.resource_bundles = {
  #   'M4CoreFoundation' => ['M4CoreFoundation/Assets/*.png']
  # }

 # s.public_header_files = 'Pod/Classes/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
