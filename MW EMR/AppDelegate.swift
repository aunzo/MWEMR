import UIKit
import RealmSwift
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        var config = Realm.Configuration()
        
        config.schemaVersion = 3
        
//        IQKeyboardManager.sharedManager().enable = true
        Realm.Configuration.defaultConfiguration = config
        
        return true

    }
}

