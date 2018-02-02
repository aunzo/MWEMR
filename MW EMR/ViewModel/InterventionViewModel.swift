import UIKit

class InterventionViewModel:PreFlightViewModel {
    
    private let customer = CustomerSingleton.sharedInstance.customerProfile
    
    func load(){
        let caseId = customer.caseId
        let items = realm.objects(Intervention.self).filter("caseId == \(caseId)")
        self.interventionItems = items
        self.interventionChange.onNext(.list)
    }
    
    func addOrUpdate(item:[String:Any]){
        var itemEdit = item
        let customer = CustomerSingleton.sharedInstance.customerProfile
        
        try! realm.write {
            if itemEdit["interventionId"] == nil {
                let obj = realm.objects(Intervention.self).last
                let insertObj = Intervention()
                if obj != nil {
                    insertObj.interventionId = (obj?.interventionId)! + 1
                }
                insertObj.customerId = customer.customerId
                insertObj.caseId = customer.caseId
                insertObj.intervention = itemEdit["intervention"]! as! String
                insertObj.date = itemEdit["date"]! as! String
                realm.add(insertObj, update: false)
            }else{
                realm.create(Intervention.self, value: itemEdit, update: true)
            }
        }
        
        self.interventionChange.onNext(.addOrUpdate)
        self.interventionChange.onNext(.list)
    }
    
    func consultInit(item:[String:Any]){
        var itemEdit = item
        let customer = CustomerSingleton.sharedInstance.customerProfile
        itemEdit["customerId"] = customer.customerId
        itemEdit["caseId"] = customer.caseId
        
        try! realm.write {
            if itemEdit["interventionId"] == nil {
                let obj = realm.objects(Intervention.self).last
                let insertObj = Intervention()
                if obj != nil {
                    insertObj.interventionId = (obj?.interventionId)! + 1
                }
                insertObj.customerId = Int(itemEdit["customerId"]! as! String)!
                insertObj.caseId = Int(itemEdit["caseId"]! as! String)!
                insertObj.intervention = itemEdit["intervention"]! as! String
                insertObj.date = itemEdit["date"]! as! String
                realm.add(insertObj, update: false)
            }else{
                realm.create(Intervention.self, value: itemEdit, update: true)
            }
        }
        self.interventionChange.onNext(.list)
    }
    
    func remove(id:String){
        let itemFind = realm.objects(Intervention.self).filter("interventionId == \(id)")
        
        try! realm.write {
            realm.delete(itemFind)
            self.interventionChange.onNext(.delete)
        }
    }
    
    func numberOfItems() -> Int {
        return self.interventionItems?.count ?? 0
    }
     
    func listItem(index:Int) -> [String:String] {
        let item : Intervention = self.interventionItems![index]
        let id = item.interventionId 
        let intervention = item.intervention 
        let date = item.date 
        return ["id":"\(id)","intervention":intervention,"date":date]
    }

}
