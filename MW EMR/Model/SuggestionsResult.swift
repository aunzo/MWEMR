import ObjectMapper
class SuggestionsResult: NSObject,NSCoding, Mappable {
    
    var id = 0
    var score = 0
    var createBy = (UserDefaults.standard.object(forKey: "username") as? String) ?? ""
    var macId = UIDevice.current.identifierForVendor?.uuidString ?? ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        id <- map["MasterData_SUGGESSION_ID"]
        score <- map["SUGGESSION_SCORE"]
        createBy <- map["CREATE_BY"]
        macId <- map["MAC_ID"]
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        self.id = aDecoder.decodeInteger(forKey: "MasterData_SUGGESSION_ID")
        self.score = aDecoder.decodeInteger(forKey: "SUGGESSION_SCORE")
        self.createBy = aDecoder.decodeObject(forKey: "createBy") as! String
        self.macId = aDecoder.decodeObject(forKey: "macId") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "MasterData_SUGGESSION_ID")
        aCoder.encode(self.score, forKey: "SUGGESSION_SCORE")
        aCoder.encode(self.createBy, forKey: "createBy")
        aCoder.encode(self.macId, forKey: "macId")
    }
    
    
}
