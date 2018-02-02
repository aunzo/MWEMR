import ObjectMapper
class RespReccordsResult: NSObject,NSCoding, Mappable {
    
    var id = 0
    var consultId = 1
    var isActive = true
    var lpm = ""
    var createBy = (UserDefaults.standard.object(forKey: "username") as? String) ?? ""
    var macId = UIDevice.current.identifierForVendor?.uuidString ?? ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        id <- map["MasterData_RESP_ID"]
        consultId <- map["ConsultForm_CONSULT_ID"]
        isActive <- map["RESP_REC_ISACTIVE"]
        lpm <- map["RESP_REC_LPM"]
        createBy <- map["CREATE_BY"]
        macId <- map["MAC_ID"]
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        self.id = aDecoder.decodeInteger(forKey: "MasterData_RESP_ID")
        self.consultId = aDecoder.decodeInteger(forKey: "ConsultForm_CONSULT_ID")
        self.isActive = aDecoder.decodeBool(forKey: "RESP_REC_ISACTIVE")
        self.lpm = aDecoder.decodeObject(forKey: "RESP_REC_LPM") as! String
        self.createBy = aDecoder.decodeObject(forKey: "createBy") as! String
        self.macId = aDecoder.decodeObject(forKey: "macId") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "MasterData_RESP_ID")
        aCoder.encode(self.consultId, forKey: "ConsultForm_CONSULT_ID")
        aCoder.encode(self.isActive, forKey: "RESP_REC_ISACTIVE")
        aCoder.encode(self.lpm, forKey: "RESP_REC_LPM")
        aCoder.encode(self.createBy, forKey: "createBy")
        aCoder.encode(self.macId, forKey: "macId")
    }
}
