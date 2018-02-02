import UIKit
import RxSwift
import RealmSwift
import CryptoSwift

class UserViewModel: NSObject {
    private let connection = Connection()
    private let bag = DisposeBag()
    private let realm = try! Realm()
    var change = PublishSubject<Void>()
    
    func load(){
        connection.get(model: User(), path: Constant.userUrl)
            .subscribe(onNext: { (model) in
                try! self.realm.write {
                    let result = self.realm.objects(User.self)
                    self.realm.delete(result)
                    self.realm.add(model,update: true)
                }
                self.change.onCompleted()
                }, onError: { (error) in
                    self.change.onError(error)
            }).disposed(by: bag)
    }
    
    func login(username:String,password:String) -> Bool {
        let password = password.sha256().uppercased()
        let status = realm.objects(User.self).filter("username = '\(username)' AND password = '\(password)'")
        
        if status.count != 0 {
            UserDefaults.standard.set((status.first?.username)!, forKey: "username")
            UserDefaults.standard.set((status.first?.userAuth)!, forKey: "userAuth")
            UserDefaults.standard.synchronize()
            return true
        }else{
            return false
        }
    }
    
    

}
