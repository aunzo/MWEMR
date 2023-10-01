import UIKit
import RealmSwift
import ObjectMapper

class MedicalUsing: Object,Mappable {
    @objc dynamic var id = 0
    @objc dynamic var itemId = 0
    @objc dynamic var barcode = ""
    @objc dynamic var customerId = 0
    @objc dynamic var caseId = 0
    @objc dynamic var name = ""
    @objc dynamic var type = ""
    @objc dynamic var typeMed = ""
    @objc dynamic var amount = 0
    @objc dynamic var note = ""
    
    required convenience init?(map: ObjectMapper.Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        itemId <- map["itemId"]
        barcode <- map["barcode"]
        caseId <- map["caseId"]
        customerId <- map["customerId"]
        name <- map["name"]
        type <- map["type"]
        typeMed <- map["typeMed"]
        amount <- map["amount"]
        note <- map["note"]
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
