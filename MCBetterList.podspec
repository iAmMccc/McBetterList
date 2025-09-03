#
# Be sure to run `pod lib lint MCBetterList.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MCBetterList'
  s.version          = '0.1.0'
  s.summary          = 'MCBetterList.'


  s.homepage         = 'https://github.com/iAmMccc'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'iAmMccc' => 'Mccc' }
  s.source           = { :git => 'https://github.com/iAmMccc/McBetterList.git', :tag => s.version.to_s }

  s.ios.deployment_target = '15.0'
  s.swift_version = '5.0'

  s.source_files = 'MCBetterList/Classes/**/*'
  
  s.subspec 'Namespace' do |ss|
    ss.source_files = "MCBetterList/Classes/Namespace/**/*"
  end

  s.subspec 'ListPlaceholder' do |ss|
    ss.source_files = "MCBetterList/Classes/ListPlaceholder/**/*"
  end
  
  s.subspec 'TableView' do |ss|
      ss.dependency 'MCBetterList/Namespace'
      ss.source_files = "MCBetterList/Classes/ListPlaceholder/**/*"
  end
  
  s.subspec 'CollectionView' do |ss|
      ss.dependency 'MCBetterList/Namespace'
      ss.source_files = "MCBetterList/Classes/ListPlaceholder/**/*"
  end
  
end
