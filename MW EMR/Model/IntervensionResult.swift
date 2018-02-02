import ObjectMapper
class InterventionsResult: NSObject, NSCoding,Mappable {
    
    var createBy = (UserDefaults.standard.object(forKey: "username") as? String) ?? ""
    var macId = UIDevice.current.identifierForVendor?.uuidString ?? ""
    var detail = ""
    var date = ""
    var id = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        id <- map["INTERVENTION_ID"]
        detail <- map["INTERVENTION_DETAIL"]
        date <- map["INTERVENTION_DATE"]
        createBy <- map["CREATE_BY"]
        macId <- map["MAC_ID"]
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        self.id = aDecoder.decodeInteger(forKey: "INTERVENTION_ID")
        self.detail = aDecoder.decodeObject(forKey: "INTERVENTION_DETAIL") as! String
        self.date = aDecoder.decodeObject(forKey: "INTERVENTION_DATE") as! String
        self.createBy = aDecoder.decodeObject(forKey: "createBy") as! String
        self.macId = aDecoder.decodeObject(forKey: "macId") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "INTERVENTION_ID")
        aCoder.encode(self.detail, forKey: "INTERVENTION_DETAIL")
        aCoder.encode(self.date, forKey: "INTERVENTION_DATE")
        aCoder.encode(self.createBy, forKey: "createBy")
        aCoder.encode(self.macId, forKey: "macId")
    }
}
