platform :ios, '12.0'

use_frameworks!
workspace 'MWEMR.xcworkspace'

target 'MW EMR' do
    pod 'Alamofire'
    pod 'RealmSwift'
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RxAlamofire'
    pod 'ObjectMapper', '~> 3.1'
    pod 'Material', '~> 2.12'
    pod 'ActionSheetPicker-3.0', '~> 2.3'
    pod 'MGSwipeTableCell', '~> 1.6'
    pod 'IQKeyboardManagerSwift'
    pod 'CryptoSwift'
    pod 'YPImagePicker'
    pod 'MWPhotoBrowser', '~> 2.1'
    pod 'SearchTextField', '~> 1.2'
    pod 'Firebase/Analytics'
end

post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
  end
 end
end
