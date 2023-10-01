import Foundation
import RealmSwift
import ObjectMapper

class Intervention: Object,Mappable {
    
    @objc dynamic var interventionId = 1
    @objc dynamic var customerId = 0
    @objc dynamic var caseId = 0
    @objc dynamic var intervention = ""
    @objc dynamic var date = ""
    
    required convenience init?(map: ObjectMapper.Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: ObjectMapper.Map) {
        interventionId <- map["interventionId"]
        customerId <- map["customerId"]
        caseId <- map["caseId"]
        intervention <- map["intervention"]
        date <- map["date"]
    }
    
    override static func primaryKey() -> String? {
        return "interventionId"
    }
}
