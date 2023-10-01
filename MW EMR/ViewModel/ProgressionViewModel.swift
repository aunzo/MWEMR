import UIKit
import RxSwift
import RealmSwift

class ProgressionViewModel {
    
    var change = PublishSubject<Void>()
    var items:Results<Progression>?
    let realm = try! Realm()
    private let customer = CustomerSingleton.sharedInstance.customerProfile
    
    func load(){
        let items = realm.objects(Progression.self).filter("caseId == \(customer.caseId)")
        self.items = items
        self.change.onNext(())
    }
    
    func add(item:[String:String]){
        let mu = createItem(item: item,action: "add")
        
        let itemFind = realm.objects(Progression.self).filter("id == \(mu.id )")
        
        if itemFind.count == 0 {
            try! realm.write {
                realm.add(mu)
            }
            self.change.onNext(())
        }else{
            self.change.onCompleted()
        }
    }
    
    func update(item:[String:String]){
        let mu = createItem(item: item,action: "update")
        
        try! realm.write {
            realm.add(mu,update: .all)
        }
        self.change.onCompleted()
    }
    
    func remove(id:String){
        let itemFind = realm.objects(Progression.self).filter("id == \(id)")
        
        try! realm.write {
            realm.delete(itemFind)
        }
    }
    
    func numberOfItems() -> Int {
        return self.items?.count ?? 0
    }
    
    func listItem(index:Int) -> [String:String] {
        let id = self.items?[index].id ?? 0
        let time = self.items?[index].time ?? ""
        let cgs = self.items?[index].cgs ?? ""
        let pupil = self.items?[index].pupil ?? ""
        let bt = self.items?[index].bt ?? ""
        let pr = self.items?[index].pr ?? ""
        let rr = self.items?[index].rr ?? ""
        let spo2 = self.items?[index].spo2 ?? ""
        let etco2 = self.items?[index].etco2 ?? ""
        let ekg = self.items?[index].ekg ?? ""
        let painScore = self.items?[index].painScore ?? ""
        let input = self.items?[index].input ?? ""
        let output = self.items?[index].output ?? ""
        let tm = self.items?[index].tm ?? ""
        let remark = self.items?[index].remark ?? ""
        let bp = self.items?[index].bp ?? ""
        return ["id":"\(id)","time":time,"cgs":cgs,"pupil":pupil,"bt":bt,"pr":pr,"rr":rr,"bp":bp,"spo2":spo2,"etco2":etco2,"ekg":ekg,"painScore":painScore,"input":input,"output":output,"tm":tm,"remark":remark]
    }
    
    private func createItem(item:[String:String],action:String) -> Progression {
        
        let pg = realm.objects(Progression.self).last
        let mu = Progression()
        if action == "add" {
            if pg?.id == nil {
                mu.id = 1
            }else{
                mu.id = pg!.id + 1
            }
        }else{
            mu.id = Int(item["id"]!)!
        }
        
        mu.time = item["time"]!
        mu.cgs = item["cgs"]!
        mu.pupil = item["pupil"]!
        mu.bt = item["bt"]!
        mu.pr = item["pr"]!
        mu.rr = item["rr"]!
        mu.bp = item["bp"]!
        mu.spo2 = item["spo2"]!
        mu.etco2 = item["etco2"]!
        mu.ekg = item["ekg"]!
        mu.painScore = item["painScore"]!
        mu.input = item["input"]!
        mu.output = item["output"]!
        mu.tm = item["tm"]!
        mu.remark = item["remark"]!
        mu.customerId = customer.customerId
        mu.caseId = customer.caseId
        
        return mu
    }
    
    
}
