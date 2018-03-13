import UIKit
import RealmSwift
import IQKeyboardManagerSwift
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        var config = Realm.Configuration()
        
        config.schemaVersion = 3
        Fabric.with([Crashlytics.self])
        Realm.Configuration.defaultConfiguration = config
        
        return true

    }
}

