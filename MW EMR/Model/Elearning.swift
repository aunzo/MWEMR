import Foundation
import RealmSwift
import ObjectMapper

class Elearning: Object,Mappable {
    
    @objc dynamic var file_id = 0
    @objc dynamic var name = ""
    @objc dynamic var path = ""
    @objc dynamic var type_name = ""
    @objc dynamic var file_type = ""
    
    required convenience init?(map: ObjectMapper.Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: ObjectMapper.Map) {
        file_id <- map["ELEARNING_FILE_ID"]
        name <- map["ELEARNING_NAME"]
        path <- map["ELEARNING_PATH"]
        type_name <- map["MasterData_ELEARNING_TYPE_NAME"]
        file_type <- map["MasterData_ELEARNING_FILE_TYPE"]
        
    }
    
    override static func primaryKey() -> String? {
        return "file_id"
    }
}
