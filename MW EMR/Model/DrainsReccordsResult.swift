import ObjectMapper
class DrainsReccordsResult: NSObject,NSCoding, Mappable {
    
    var id = 0
    var consultId = 1
    var isActive = true
    var createBy = (UserDefaults.standard.object(forKey: "username") as? String) ?? ""
    var macId = UIDevice.current.identifierForVendor?.uuidString ?? ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        id <- map["MasterData_DRAINS_ID"]
        consultId <- map["ConsultForm_CONSULT_ID"]
        isActive <- map["DRAINS_REC_ISACTIVE"]
        createBy <- map["CREATE_BY"]
        macId <- map["MAC_ID"]
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        self.id = aDecoder.decodeInteger(forKey: "MasterData_DRAINS_ID")
        self.consultId = aDecoder.decodeInteger(forKey: "ConsultForm_CONSULT_ID")
        self.isActive = aDecoder.decodeBool(forKey: "DRAINS_REC_ISACTIVE")
        self.createBy = aDecoder.decodeObject(forKey: "createBy") as! String
        self.macId = aDecoder.decodeObject(forKey: "macId") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "MasterData_DRAINS_ID")
        aCoder.encode(self.consultId, forKey: "ConsultForm_CONSULT_ID")
        aCoder.encode(self.isActive, forKey: "DRAINS_REC_ISACTIVE")
        aCoder.encode(self.createBy, forKey: "createBy")
        aCoder.encode(self.macId, forKey: "macId")
    }
}
