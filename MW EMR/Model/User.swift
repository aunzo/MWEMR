import Foundation
import RealmSwift
import ObjectMapper

class User: Object,Mappable {
    @objc dynamic var id = 0
    @objc dynamic var userAuth = 0
    @objc dynamic var username = ""
    @objc dynamic var password = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        id <- map["USER_ID"]
        userAuth <- map["USER_AUTHEN"]
        username <- map["USER_USERNAME"]
        password <- map["USER_PASSWORD"]
        
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
