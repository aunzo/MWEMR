import ObjectMapper

class SummaryReportResult: NSObject,NSCoding, Mappable {
    var id = 0
    var title = ""
    var path = ""
    var isUpload = false
    var createBy = (UserDefaults.standard.object(forKey: "username") as? String) ?? ""
    var macId = UIDevice.current.identifierForVendor?.uuidString ?? ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        id <- map["REPORT_FILE_ID"]
        title <- map["REPORT_FILE_NAME"]
        path <- map["REPORT_FILE_PATH"]
        isUpload <- map["REPORT_ISUPLOAD"]
        createBy <- map["CREATE_BY"]
        macId <- map["MAC_ID"]
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        self.id = aDecoder.decodeInteger(forKey: "REPORT_FILE_ID")
        self.title = aDecoder.decodeObject(forKey: "REPORT_FILE_NAME") as! String
        self.path = aDecoder.decodeObject(forKey: "REPORT_FILE_PATH") as! String
        self.isUpload = aDecoder.decodeBool(forKey: "REPORT_ISUPLOAD")
        self.createBy = aDecoder.decodeObject(forKey: "createBy") as! String
        self.macId = aDecoder.decodeObject(forKey: "macId") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "REPORT_FILE_ID")
        aCoder.encode(self.title, forKey: "REPORT_FILE_NAME")
        aCoder.encode(self.path, forKey: "REPORT_FILE_PATH")
        aCoder.encode(self.isUpload, forKey: "REPORT_ISUPLOAD")
        aCoder.encode(self.createBy, forKey: "createBy")
        aCoder.encode(self.macId, forKey: "macId")
    }
}
