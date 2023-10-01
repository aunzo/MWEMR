import Foundation
import RealmSwift
import ObjectMapper

class Customer: Object,Mappable {
    
    @objc dynamic var customerId = 0
    @objc dynamic var caseId = 0
    @objc dynamic var personalId = ""
    @objc dynamic var fullName = ""
    @objc dynamic var gender = ""
    @objc dynamic var birthDay = ""
    @objc dynamic var age = 0
    @objc dynamic var isDelete = 0
    
    required convenience init?(map: ObjectMapper.Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: ObjectMapper.Map) {
        customerId <- map["customerId"]
        caseId <- map["caseId"]
        personalId <- map["personalId"]
        fullName <- map["fullName"]
        gender <- map["gender"]
        birthDay <- map["birthDay"]
        age <- map["age"]
        isDelete <- map["isDelete"]
        
    }
    
    override static func primaryKey() -> String? {
        return "caseId"
    }
}

class CaseDetail:Object {
    @objc dynamic var customerId = 0
    @objc dynamic var caseId = 0
    @objc dynamic var detail = ""
    
    override static func primaryKey() -> String? {
        return "caseId"
    }
}
