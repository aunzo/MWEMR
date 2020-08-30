platform :ios, '9.0'

use_frameworks!
workspace 'MWEMR.xcworkspace'

target 'MW EMR' do
    pod 'Alamofire', '~> 4.5'
    pod 'RealmSwift', '~> 3.20.0'
    pod 'RxSwift',    '~> 4.0'
    pod 'RxCocoa',    '~> 4.0'
    pod 'RxAlamofire', '~> 4.0'
    pod 'ObjectMapper', '~> 3.1'
    pod 'Material', '~> 2.12'
    pod 'ActionSheetPicker-3.0', '~> 2.3'
    pod 'MGSwipeTableCell', '~> 1.6'
    pod 'IQKeyboardManagerSwift', '~> 5.0'
    pod 'CryptoSwift'
    pod 'ALCameraViewController'
    pod 'MWPhotoBrowser', '~> 2.1'
    pod 'SearchTextField', '~> 1.2'
    pod 'Firebase/Analytics'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.1'
        end
    end
end
