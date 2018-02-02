import ObjectMapper
class ProgressionsResult: NSObject,NSCoding, Mappable {
    
    var time = ""
    var gcs = ""
    var pupil = ""
    var bt = ""
    var pr = ""
    var rr = ""
    var bp = ""
    var spo2 = ""
    var etco2 = ""
    var ekg = ""
    var painScore = ""
    var input = ""
    var output = ""
    var treatment = ""
    var remark = ""
    var createBy = (UserDefaults.standard.object(forKey: "username") as? String) ?? ""
    var macId = UIDevice.current.identifierForVendor?.uuidString ?? ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        time <- map["PROGESSION_TIME"]
        gcs <- map["PROGESSION_GCS"]
        pupil <- map["PROGESSION_PUPIL"]
        bt <- map["PROGESSION_BT"]
        pr <- map["PROGESSION_PR"]
        rr <- map["PROGESSION_RR"]
        bp <- map["PROGESSION_BP"]
        spo2 <- map["PROGESSION_SPO2"]
        etco2 <- map["PROGESSION_ETCO2"]
        ekg <- map["PROGESSION_EKG"]
        painScore <- map["PROGESSION_PAINSCORE"]
        input <- map["PROGESSION_INPUT"]
        output <- map["PROGESSION_OUTPUT"]
        treatment <- map["PROGESSION_TREATMENT"]
        remark <- map["PROGESSION_REMARK"]
        createBy <- map["CREATE_BY"]
        macId <- map["MAC_ID"]
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        self.time = aDecoder.decodeObject(forKey: "PROGESSION_TIME") as! String
        self.gcs = aDecoder.decodeObject(forKey: "PROGESSION_GCS") as! String
        self.pupil = aDecoder.decodeObject(forKey: "PROGESSION_PUPIL") as! String
        self.bt = aDecoder.decodeObject(forKey: "PROGESSION_BT") as! String
        self.pr = aDecoder.decodeObject(forKey: "PROGESSION_PR") as! String
        self.rr = aDecoder.decodeObject(forKey: "PROGESSION_RR") as! String
        self.bp = aDecoder.decodeObject(forKey: "PROGESSION_BP") as! String
        self.spo2 = aDecoder.decodeObject(forKey: "PROGESSION_SPO2") as! String
        self.etco2 = aDecoder.decodeObject(forKey: "PROGESSION_ETCO2") as! String
        self.ekg = aDecoder.decodeObject(forKey: "PROGESSION_EKG") as! String
        self.painScore = aDecoder.decodeObject(forKey: "PROGESSION_PAINSCORE") as! String
        self.input = aDecoder.decodeObject(forKey: "PROGESSION_INPUT") as! String
        self.output = aDecoder.decodeObject(forKey: "PROGESSION_OUTPUT") as! String
        self.treatment = aDecoder.decodeObject(forKey: "PROGESSION_TREATMENT") as! String
        self.remark = aDecoder.decodeObject(forKey: "PROGESSION_REMARK") as! String
        self.createBy = aDecoder.decodeObject(forKey: "createBy") as! String
        self.macId = aDecoder.decodeObject(forKey: "macId") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.time, forKey: "PROGESSION_TIME")
        aCoder.encode(self.gcs, forKey: "PROGESSION_GCS")
        aCoder.encode(self.pupil, forKey: "PROGESSION_PUPIL")
        aCoder.encode(self.bt, forKey: "PROGESSION_BT")
        aCoder.encode(self.pr, forKey: "PROGESSION_PR")
        aCoder.encode(self.rr, forKey: "PROGESSION_RR")
        aCoder.encode(self.bp, forKey: "PROGESSION_BP")
        aCoder.encode(self.spo2, forKey: "PROGESSION_SPO2")
        aCoder.encode(self.etco2, forKey: "PROGESSION_ETCO2")
        aCoder.encode(self.ekg, forKey: "PROGESSION_EKG")
        aCoder.encode(self.painScore, forKey: "PROGESSION_PAINSCORE")
        aCoder.encode(self.input, forKey: "PROGESSION_INPUT")
        aCoder.encode(self.output, forKey: "PROGESSION_OUTPUT")
        aCoder.encode(self.treatment, forKey: "PROGESSION_TREATMENT")
        aCoder.encode(self.remark, forKey: "PROGESSION_REMARK")
        aCoder.encode(self.createBy, forKey: "createBy")
        aCoder.encode(self.macId, forKey: "macId")
    }
}
