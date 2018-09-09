import UIKit

class InterventionViewModel:PreFlightViewModel {
    
    private let customer = CustomerSingleton.sharedInstance.customerProfile
    
    func load()
    {
        interventionItems = realm.objects(Intervention.self).filter("caseId == \(customer.caseId)")
        interventionChange.onNext(.list)
    }
    
    private func reload()
    {
        interventionChange.onNext(.addOrUpdate)
        interventionChange.onNext(.list)
    }
    
    func add(item: Intervention)
    {
        realm.beginWrite()
        if let obj = realm.objects(Intervention.self).last
        {
            item.interventionId = obj.interventionId + 1
        }
        
        item.customerId = customer.customerId
        item.caseId = customer.caseId
        realm.add(item, update: false)
        
        try? realm.commitWrite()
        
        reload()
    }
    
    func update(item: Intervention)
    {
        realm.beginWrite()
        
        item.customerId = customer.customerId
        item.caseId = customer.caseId
        
        realm.create(Intervention.self, value: item, update: true)
        
        try? realm.commitWrite()
        
        reload()
    }
    
    func consultInit(item: Intervention)
    {
        item.customerId = customer.customerId
        item.caseId = customer.caseId
        
        realm.beginWrite()
        
        realm.add(item, update: false)
        
        try? realm.commitWrite()
        
        interventionChange.onNext(.list)
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
