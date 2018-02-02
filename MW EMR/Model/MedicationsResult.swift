import ObjectMapper
class MedicationsResult: NSObject,NSCoding, Mappable {
    
    var id = 0
    var note = ""
    var stockTypeName = "STOCK_OUT"
    var balance = 0
    var createBy = (UserDefaults.standard.object(forKey: "username") as? String) ?? ""
    var macId = UIDevice.current.identifierForVendor?.uuidString ?? ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        id <- map["Medication_MEDICATION_ID"]
        note <- map["MEDHIS_NOTE"]
        stockTypeName <- map["MEDHIS_STOCKTYPE_NAME"]
        balance <- map["MEDHIS_BALANCE"]
        createBy <- map["CREATE_BY"]
        macId <- map["MAC_ID"]
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        self.id = aDecoder.decodeInteger(forKey: "Medication_MEDICATION_ID")
        self.note = aDecoder.decodeObject(forKey: "MEDHIS_NOTE") as! String
        self.stockTypeName = aDecoder.decodeObject(forKey: "MEDHIS_STOCKTYPE_NAME") as! String
        self.balance = aDecoder.decodeInteger(forKey: "MEDHIS_BALANCE")
        self.createBy = aDecoder.decodeObject(forKey: "createBy") as! String
        self.macId = aDecoder.decodeObject(forKey: "macId") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "Medication_MEDICATION_ID")
        aCoder.encode(self.note, forKey: "MEDHIS_NOTE")
        aCoder.encode(self.stockTypeName, forKey: "MEDHIS_STOCKTYPE_NAME")
        aCoder.encode(self.balance, forKey: "MEDHIS_BALANCE")
        aCoder.encode(self.createBy, forKey: "createBy")
        aCoder.encode(self.macId, forKey: "macId")
    }
}
