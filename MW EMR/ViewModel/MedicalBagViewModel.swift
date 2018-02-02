import UIKit
import RxSwift
import RxCocoa
import RealmSwift
import ObjectMapper
import MBProgressHUD

class MedicalBagViewModel {
    private let connection = Connection()
    private let bag = DisposeBag()
    private var model:[MedicalBag] = []
    private var detailBag:Results<MedicalBagDetail>?
    private let realm = try! Realm()
    final private var tempModel:[[String:Any]] = []
    var change = PublishSubject<Void>()
    
    func load(view:UIView){
        MBProgressHUD.showAdded(to: view, animated: true)
        connection.get(model: MedicalBag(), path: Constant.allBagUrl)
            .subscribe(onNext: { (model) in
                self.model = model
                self.tempModel = model.toJSON()
                MBProgressHUD.hide(for: view, animated: true)
                self.change.onCompleted()
                }, onError: { (error) in
                    self.model = try! Realm().objects(MedicalBag.self).toArray(ofType: MedicalBag.self)
                    self.tempModel = self.model.toJSON()
                    MBProgressHUD.hide(for: view, animated: true)
                    self.change.onCompleted()
            }).disposed(by: bag)
    }
    
    func loadFromLocal(){
        self.model = realm.objects(MedicalBag.self).toArray(ofType: MedicalBag.self)
        self.change.onCompleted()
    }
    
    func numberOfItems() -> Int {
        return self.model.count
    }
    
    func itemAt(index:Int) -> (bag_id:Int,name:String) {
        let item = self.model[index]
        return (item.bag_id,item.name)
    }
    
    func itemIsDownloaded(index:Int) -> Bool {
        let cus = try! Realm().objects(MedicalBag.self).toArray(ofType: MedicalBag.self)
        if cus.contains(where: {$0.bag_id == self.model[index].bag_id}) {
            return true
        } else {
            return false
        }
    }
    
    func downloadToLocal(index:Int){
        if let bag = try! Realm().objects(MedicalBag.self).first {
            try! realm.write {
                realm.delete(bag)
            }
        }
        
        if let obj = model.filter({$0.bag_id == self.model[index].bag_id}).first {
            try! realm.write {
                realm.add(obj)
            }
        }
        
        self.model = Mapper<MedicalBag>().mapArray(JSONArray: self.tempModel)
        
        self.change.onCompleted()
    }
    
    func loadDetailBag(view:UIView,index:Int) -> Observable<Void>{
        MBProgressHUD.showAdded(to: view, animated: true)
        connection.get(model: MedicalBagDetail(), path: Constant.bagDetailUrl + "?bagId=\(self.model[index].bag_id)")
            .subscribe(onNext: { (model) in
                try! self.realm.write {
                    let bDetail = self.realm.objects(MedicalBagDetail.self)
                    let bMDetail = self.realm.objects(MedicalBagDetailMedications.self)
                    let bEDetail = self.realm.objects(MedicalBagDetailEquipments.self)
                    self.realm.delete(bDetail)
                    self.realm.delete(bMDetail)
                    self.realm.delete(bEDetail)
                    self.realm.add(model)
                }
                MBProgressHUD.hide(for: view, animated: true)
                }, onError: { (error) in
                    MBProgressHUD.hide(for: view, animated: true)
            }).disposed(by: bag)
        
        return Observable.create({ (observer) -> Disposable in
            observer.onCompleted()
            return Disposables.create()
        })
    }
    
    func getDetailBag(){
        self.detailBag = self.realm.objects(MedicalBagDetail.self)
    }
    
    func sendBagToServer(view:UIView)-> Observable<Void>{
        return Observable.create({ (observer) -> Disposable in
            let bagId = self.realm.objects(MedicalBag.self).first?.bag_id
            MBProgressHUD.showAdded(to: view, animated: true)
            let connect = Connection()
            connect.uploadBag(bagId: bagId!).subscribe( onCompleted: {
                MBProgressHUD.hide(for: view, animated: true)
                self.deleteDetailBag()
                observer.onCompleted()
                }).disposed(by: self.bag)
            
            return Disposables.create()
        })
    }
    
    func deleteDetailBag(){
        try! self.realm.write {
            self.realm.delete(self.realm.objects(MedicalBagDetail.self))
            self.realm.delete(self.realm.objects(MedicalBag.self))
        }
    }
    
    func numberOfMedicalEquipments() -> Int {
        return self.detailBag?.first?.bagEquipments.count ?? 0
    }
    
    func numberOfMedicalMedications() -> Int {
        return self.detailBag?.first?.bagMedications.count ?? 0
    }
    
    func itemOfMedication(index:Int) -> (barcode:String,name:String,amount:Int,typeName:String) {
        let item = self.detailBag?.first?.bagMedications[index]
        return ((item?.barcode)!,(item?.name)!,(item?.amount)!,(item?.type_name)!)
    }
    
    func itemOfEquipment(index:Int) -> (barcode:String,name:String,typeName:String) {
        let item = self.detailBag?.first?.bagEquipments[index]
        return ((item?.barcode)!,(item?.name)!,(item?.type_name)!)
    }
    
    func listNameItemWith(typeMed:String) -> (id : [Int],barcode :[String], value : [String], type : [String], amount : [Int]){
        let result = self.realm.objects(MedicalBagDetail.self)
        var value = [String]()
        var type = [String]()
        var barcode = [String]()
        var amount = [Int]()
        var id = [Int]()
        
        if typeMed == "Medication" {
            for res in (result.first?.bagMedications)! {
                value.append(res.barcode + " - " + res.name)
                barcode.append(res.barcode)
                type.append(res.type_name)
                amount.append(res.amount)
                id.append(res.id)
            }
        }else{
            for res in (result.first?.bagEquipments)! {
                value.append(res.barcode + " - " + res.name)
                barcode.append(res.barcode)
                type.append(res.type_name)
                amount.append(0)
                id.append(res.id)
                
            }
        }
        return (id,barcode,value,type,amount)
    }
}
