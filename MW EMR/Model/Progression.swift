import UIKit
import RealmSwift
import ObjectMapper

class Progression: Object,Mappable {
    @objc dynamic var customerId = 0
    @objc dynamic var caseId = 0
    @objc dynamic var id = 0
    @objc dynamic var time = ""
    @objc dynamic var cgs = ""
    @objc dynamic var pupil = ""
    @objc dynamic var bt = ""
    @objc dynamic var pr = ""
    @objc dynamic var rr = ""
    @objc dynamic var bp = ""
    @objc dynamic var spo2 = ""
    @objc dynamic var etco2 = ""
    @objc dynamic var ekg = ""
    @objc dynamic var painScore = ""
    @objc dynamic var input = ""
    @objc dynamic var output = ""
    @objc dynamic var tm = ""
    @objc dynamic var remark = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        customerId <- map["customerId"]
        caseId <- map["caseId"]
        id <- map["id"]
        time <- map["time"]
        cgs <- map["cgs"]
        pupil <- map["pupil"]
        bt <- map["bt"]
        pr <- map["pr"]
        rr <- map["rr"]
        bp <- map["bp"]
        spo2 <- map["spo2"]
        etco2 <- map["etco2"]
        ekg <- map["ekg"]
        painScore <- map["painScore"]
        input <- map["input"]
        output <- map["output"]
        tm <- map["tm"]
        remark <- map["remark"]
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
