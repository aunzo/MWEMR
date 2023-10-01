import UIKit
import RealmSwift
import IQKeyboardManagerSwift
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        FirebaseApp.configure()
        
        var config = Realm.Configuration()
        
        config.schemaVersion = 3
        Realm.Configuration.defaultConfiguration = config
        
        return true
    }
}

