#
# Be sure to run `pod lib lint ModelA.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ModelA'
  s.version          = '0.3.6'
  s.summary          = 'ModelA组件'
  s.swift_version    = '5'
  

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/JL521/ModelA'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JL521' => '314886745@qq.com' }
  s.source           = { :git => 'https://github.com/JL521/ModelA.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'ModelA/Classes/**/*'
  #s.resource_bundles = {
  #   'ModelA' => ['ModelA/Classes/Jobwanted/jobimg/*']
  #}

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  
  s.dependency 'Moya-ObjectMapper/RxSwift','2.8'
  s.dependency 'IQKeyboardManagerSwift','~> 6.5.5'
  s.dependency 'NVActivityIndicatorView','~> 4.8.0'
  s.dependency 'SwiftEntryKit','~> 1.1.3'
  s.dependency 'SwiftyJSON','~> 4.0' 
  s.dependency 'SDWebImage','~> 5.6.0'
  s.dependency 'MJRefresh','~> 3.3.1'
  
end
