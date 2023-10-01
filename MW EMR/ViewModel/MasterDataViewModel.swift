import UIKit
import RxSwift
import RxCocoa
import RealmSwift

class MasterDataViewModel: NSObject {
    private let connection = Connection()
    private let bag = DisposeBag()
    private let realm = try! Realm()
    var change = PublishSubject<Void>()
    
    func load(){
        connection.get(model: MasterData(), path: Constant.masterDataUrl)
            .subscribe(onNext: { (model) in
                try! self.realm.write {
                    let result = self.realm.objects(MasterData.self)
                    self.realm.delete(result)
                    self.realm.add(model, update: .all)
                }
                self.change.onCompleted()
                }, onError: { (error) in
                    self.change.onError(error)
            }).disposed(by: bag)
    }
    
    func checkDataInLocal() -> Bool {
        if self.realm.objects(MasterData.self).count > 0 {
            return true
        }else{
            return false
        }
    }
    
    func getDataWith(masterFieldID id : Int) -> [String] {
        let result = self.realm.objects(MasterData.self).filter("fieldID == \(id)")
        var data = [String]()
        for res in result {
            data.append(res.name)
        }
        return data
    }
}
