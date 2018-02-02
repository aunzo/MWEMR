import ObjectMapper
class RecieveItemResult: NSObject,NSCoding, Mappable {
    var id = 0
    var recieveItemSend = true
    var createBy = (UserDefaults.standard.object(forKey: "username") as? String) ?? ""
    var macId = UIDevice.current.identifierForVendor?.uuidString ?? ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        id <- map["MasterData_RECIEVE_ITEM_ID"]
        recieveItemSend <- map["RECIEVE_ITEM_SEND"]
        createBy <- map["CREATE_BY"]
        macId <- map["MAC_ID"]
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        self.id = aDecoder.decodeInteger(forKey: "MasterData_RECIEVE_ITEM_ID")
        self.recieveItemSend = aDecoder.decodeBool(forKey: "RECIEVE_ITEM_SEND")
        self.createBy = aDecoder.decodeObject(forKey: "createBy") as! String
        self.macId = aDecoder.decodeObject(forKey: "macId") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "MasterData_RECIEVE_ITEM_ID")
        aCoder.encode(self.recieveItemSend, forKey: "RECIEVE_ITEM_SEND")
        aCoder.encode(self.createBy, forKey: "createBy")
        aCoder.encode(self.macId, forKey: "macId")
    }
}
