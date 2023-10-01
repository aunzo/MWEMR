import Foundation
import RealmSwift
import ObjectMapper

class SummaryReport: Object,Mappable {
    
    @objc dynamic var customerId = 0
    @objc dynamic var caseId = 0
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var path = ""
    @objc dynamic var isUpload = false
    required convenience init?(map: ObjectMapper.Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: ObjectMapper.Map) {
        customerId <- map["customerId"]
        caseId <- map["caseId"]
        id <- map["REPORT_FILE_ID"]
        title <- map["REPORT_FILE_NAME"]
        path <- map["REPORT_FILE_PATH"]
        isUpload <- map["REPORT_ISUPLOAD"]
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
