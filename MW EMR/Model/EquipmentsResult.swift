import ObjectMapper
class EquipmentsResult: NSObject,NSCoding, Mappable {
    
    var id = 0
    var note = ""
    var createBy = (UserDefaults.standard.object(forKey: "username") as? String) ?? ""
    var macId = UIDevice.current.identifierForVendor?.uuidString ?? ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        id <- map["EQU_HISTORY_ID"]
        note <- map["EQUIPMENT_USE_NOTE"]
        createBy <- map["CREATE_BY"]
        macId <- map["MAC_ID"]
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        self.id = aDecoder.decodeInteger(forKey: "EQU_HISTORY_ID")
        self.note = aDecoder.decodeObject(forKey: "EQUIPMENT_USE_NOTE") as! String
        self.createBy = aDecoder.decodeObject(forKey: "createBy") as! String
        self.macId = aDecoder.decodeObject(forKey: "macId") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "EQU_HISTORY_ID")
        aCoder.encode(self.note, forKey: "EQUIPMENT_USE_NOTE")
        aCoder.encode(self.createBy, forKey: "createBy")
        aCoder.encode(self.macId, forKey: "macId")
    }
}
