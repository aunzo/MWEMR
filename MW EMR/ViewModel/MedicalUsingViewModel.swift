import UIKit
import RxSwift
import RealmSwift

class MedicalUsingViewModel {
    
    var change = PublishSubject<DataAction>()
    var items:Results<MedicalUsing>?
    let realm = try! Realm()
    private let customer = CustomerSingleton.sharedInstance.customerProfile
    
    func load(){
        let items = realm.objects(MedicalUsing.self).filter("caseId == \(customer.caseId)")
        self.items = items
        self.change.onNext(.list)
    }
    
    func addOrUpdate(item:[String:Any],state:String){
        var itemEdit = item

        try! realm.write {
            if state != "edit" {
                itemEdit["id"] = self.IncrementaID()
            }
            
            itemEdit["caseId"] = customer.caseId
            itemEdit["customerId"] = customer.customerId
            
            if itemEdit["typeMed"] as! String == "Medication" {
                let bagItem = realm.objects(MedicalBagDetailMedications.self).filter("barcode = '\(itemEdit["barcode"]! as! String)'").first

                bagItem?.amount = (bagItem?.amount)! + (itemEdit["amountResult"]! as! Int)
                
                realm.add(bagItem!, update: .all)
            }else{
                itemEdit["amount"] = 1
            }
            
            realm.create(MedicalUsing.self, value: itemEdit, update: .all)
        }
        
        self.change.onNext(.addOrUpdate)
        self.change.onNext(.list)
    }
    
    func remove(id:String){
        let itemFind = realm.objects(MedicalUsing.self).filter("id == \(id)")
        let bag = realm.objects(MedicalBagDetailMedications.self).filter("id == \(itemFind.first?.itemId ?? 0)")
        try! realm.write {
            if bag.first != nil && itemFind.first != nil {
                bag.first?.amount = (bag.first?.amount)! + (itemFind.first?.amount)!
            }
            realm.add(bag, update: .all)
            realm.delete(itemFind)
            self.change.onNext(.delete)
        }
        
    }
    
    func numberOfItems() -> Int {
        return self.items?.count ?? 0
    }
    
    func listItem(index:Int) -> [String:String] {
        let id = self.items?[index].id ?? 0
        let itemId = self.items?[index].itemId ?? 0
        let barcode = self.items?[index].barcode ?? ""
        let name = self.items?[index].name ?? ""
        let type = self.items?[index].type ?? ""
        let typeMed = self.items?[index].typeMed ?? ""
        let amount = self.items?[index].amount ?? 0
        let note = self.items?[index].note ?? ""
        return ["id":"\(id)","itemId":"\(itemId)","barcode":barcode,"name":name,"typeMed":typeMed,"type":type,"amount":"\(amount)","note":note]
    }
    
    func IncrementaID() -> Int {
        let realm = try! Realm()
        let RetNext: Array = Array(realm.objects(MedicalUsing.self).sorted(byKeyPath: "id"))
        let last = RetNext.last
        if RetNext.count > 0 {
            let valor = last?.value(forKey: "id") as? Int
            return valor! + 1
        } else {
            return 1
        }
    }
    
    
}
