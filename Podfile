# Uncomment the next line to define a global platform for your project
install! 'cocoapods', :warn_for_unused_master_specs_repo => false

def database
  pod 'SQLite.swift', '~> 0.13.0'
end

def net
  pod 'Alamofire'
end

def reactive
  pod 'RxSwift', '6.5.0'
  pod 'RxCocoa', '6.5.0'
end

target 'SwiftHelper (iOS)' do
  platform :ios, '16.0'
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SwiftHelper (iOS)
  database
  net
  reactive
  
  pod 'JXSegmentedView'
  
  pod 'Kingfisher', '~> 7.0'
  pod 'SnapKit', '~> 5.6.0'
  pod 'SwiftKeychainWrapper'
  pod 'IQKeyboardManagerSwift', '~> 6.5.10'
  
#  HUD
  pod 'ProgressHUD', '~> 13.6.2'
  
#  pod 'OpenCV', '~> 4.3.0'
  
end

target 'SwiftHelper (macOS)' do
  platform :osx, '12.0'
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SwiftHelper (macOS)
  database
  net
  reactive
end

target 'SwiftHelperIntent' do
  platform :ios, '14.0'
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SwiftHelperIntent

end

target 'SwiftHelperWidgetExtension' do
  platform :ios, '14.0'
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SwiftHelperWidgetExtension

end

#修复M1芯片 模拟器运行， 之后如需在真机上运行需注释pod install一下。
#post_install do |installer|
#  installer.pods_project.build_configurations.each do |config|
#    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
#  end
#end
