platform :ios, '12.0'
use_frameworks!

inhibit_all_warnings!

target 'JetDevsHomeWork' do
  pod 'RxSwift', '~> 5.1.0'
  pod 'RxCocoa', '~> 5.1.0'
  pod 'SwiftLint' , '~> 0.44.0'
  pod 'MaterialComponents/TextControls+OutlinedTextFields'
  pod 'IQKeyboardManagerSwift'
  pod 'Kingfisher'

  target 'JetDevsHomeWorkTests' do
    inherit! :search_paths
  end

  target 'JetDevsHomeWorkUITests' do
    inherit! :complete
  end  

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12'
    end
  end
end
