import ObjectMapper
class FlightPersonsResult: NSObject,NSCoding, Mappable {
    
    var id = 0
    var name = ""
    var createBy = (UserDefaults.standard.object(forKey: "username") as? String) ?? ""
    var macId = UIDevice.current.identifierForVendor?.uuidString ?? ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        id <- map["MasterData_POSITION_ID"]
        name <- map["FLIGHT_PERSON_NAME"]
        createBy <- map["CREATE_BY"]
        macId <- map["MAC_ID"]
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        self.id = aDecoder.decodeInteger(forKey: "MasterData_POSITION_ID")
        self.name = aDecoder.decodeObject(forKey: "FLIGHT_PERSON_NAME") as! String
        self.createBy = aDecoder.decodeObject(forKey: "createBy") as! String
        self.macId = aDecoder.decodeObject(forKey: "macId") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "MasterData_POSITION_ID")
        aCoder.encode(self.name, forKey: "FLIGHT_PERSON_NAME")
        aCoder.encode(self.createBy, forKey: "createBy")
        aCoder.encode(self.macId, forKey: "macId")
    }
}
