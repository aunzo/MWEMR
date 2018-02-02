import ObjectMapper
class FlightInfoResult: NSObject,NSCoding, Mappable {
    
    var depTakeoff = ""
    var depFromAirport = ""
    var depLanding = ""
    var deptoAirport = ""
    var depAmbulancePickup = ""
    var depArriveHospital = ""
    var depLeaveHospital = ""
    var depGiveBy = ""
    var depRecieveBy = ""
    var arriveTakeoff = ""
    var arriveFromAirport = ""
    var arriveLanding = ""
    var arriveToAirport = ""
    var arriveAmbulancePickup = ""
    var arriveHandover = ""
    var arriveTime = ""
    var arriveGiveBy = ""
    var arriveRecieveBy = ""
    var painassessmentTypeId = 0
    var characteristicId = 0
    var characOther = ""
    var location = ""
    var duration = ""
    var frequencyId = 0
    var recieveItems = [RecieveItemResult]()
    var createBy = (UserDefaults.standard.object(forKey: "username") as? String) ?? ""
    var macId = UIDevice.current.identifierForVendor?.uuidString ?? ""
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        depTakeoff <- map["FLIGHT_INFO_DEP_TAKEOFF"]
        depFromAirport <- map["FILGHT_INFO_DEP_FROM_AIRPORT"]
        depLanding <- map["FLIGHT_INFO_DEP_LANDING"]
        deptoAirport <- map["FLIGHT_INFO_DEP_TOAIRPORT"]
        depAmbulancePickup <- map["FLIGHT_INFO_DEP_AMBULANCE_PICKUP"]
        depArriveHospital <- map["FLIGHT_INFO_DEP_ARRIVE_HOSPITAL"]
        depLeaveHospital <- map["FLIGHT_INFO_DEP_LEAVE_HOSPITAL"]
        depGiveBy <- map["FLIGHT_INFO_DEP_GIVEBY"]
        depRecieveBy <- map["FLIGHT_INFO_DEP_RECIEVEBY"]
        arriveTakeoff <- map["FLIGHT_INFO_ARRIVE_TAKEOFF"]
        arriveFromAirport <- map["FLIGHT_INFO_ARRIVE_FROMAIRPORT"]
        arriveLanding <- map["FLIGHT_INFO_ARRIVE_LANDING"]
        arriveToAirport <- map["FLIGHT_INFO_ARRIVE_TOAIRPORT"]
        arriveAmbulancePickup <- map["FLIGHT_INFO_ARRIVE_AMBULANCE_PICKUP"]
        arriveHandover <- map["FLIGHT_INFO_ARRIVE_HANDOVER"]
        arriveTime <- map["FLIGHT_INFO_ARRIVE_TIME"]
        arriveGiveBy <- map["FLIGHT_INFO_ARRIVE_GIVEBY"]
        arriveRecieveBy <- map["FLIGHT_INFO_ARRIVE_RECIEVEBY"]
        painassessmentTypeId <- map["MasterData_PAINASSESSMENT_TYPE_ID"]
        characteristicId <- map["MasterData_CHARACTERISTIC_ID"]
        characOther <- map["FLIGHT_INFO_CHARAC_OTHER"]
        location <- map["FLIGHT_INFO_LOCATION"]
        duration <- map["FLIGHT_INFO_DURATION"]
        frequencyId <- map["MasterData_FREQUENCY_ID"]
        recieveItems <- map["RecieveItems"]
        createBy <- map["CREATE_BY"]
        macId <- map["MAC_ID"]
        
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        self.depTakeoff = aDecoder.decodeObject(forKey: "depTakeoff") as! String
        self.depFromAirport = aDecoder.decodeObject(forKey: "depFromAirport") as! String
        self.depLanding = aDecoder.decodeObject(forKey: "depLanding") as! String
        self.deptoAirport = aDecoder.decodeObject(forKey: "deptoAirport") as! String
        self.depAmbulancePickup = aDecoder.decodeObject(forKey: "depAmbulancePickup") as! String
        self.depArriveHospital = aDecoder.decodeObject(forKey: "depArriveHospital") as! String
        self.depLeaveHospital = aDecoder.decodeObject(forKey: "depLeaveHospital") as! String
        self.depGiveBy = aDecoder.decodeObject(forKey: "depGiveBy") as! String
        self.depRecieveBy = aDecoder.decodeObject(forKey: "depRecieveBy") as! String
        self.arriveTakeoff = aDecoder.decodeObject(forKey: "arriveTakeoff") as! String
        self.arriveFromAirport = aDecoder.decodeObject(forKey: "arriveFromAirport") as! String
        self.arriveLanding = aDecoder.decodeObject(forKey: "arriveLanding") as! String
        self.arriveToAirport = aDecoder.decodeObject(forKey: "arriveToAirport") as! String
        self.arriveAmbulancePickup = aDecoder.decodeObject(forKey: "arriveAmbulancePickup") as! String
        self.arriveHandover = aDecoder.decodeObject(forKey: "arriveHandover") as! String
        self.arriveTime = aDecoder.decodeObject(forKey: "arriveTime") as! String
        self.arriveGiveBy = aDecoder.decodeObject(forKey: "arriveGiveBy") as! String
        self.arriveRecieveBy = aDecoder.decodeObject(forKey: "arriveRecieveBy") as! String
        self.painassessmentTypeId = aDecoder.decodeInteger(forKey: "painassessmentTypeId")
        self.characteristicId = aDecoder.decodeInteger(forKey: "characteristicId")
        self.characOther = aDecoder.decodeObject(forKey: "characOther") as! String
        self.location = aDecoder.decodeObject(forKey: "location") as! String
        self.duration = aDecoder.decodeObject(forKey: "duration") as! String
        self.frequencyId = aDecoder.decodeInteger(forKey: "frequencyId")
        self.recieveItems = aDecoder.decodeObject(forKey: "recieveItems") as! [RecieveItemResult]
        self.createBy = aDecoder.decodeObject(forKey: "createBy") as! String
        self.macId = aDecoder.decodeObject(forKey: "macId") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.depTakeoff, forKey: "depTakeoff")
        aCoder.encode(self.depFromAirport, forKey: "depFromAirport")
        aCoder.encode(self.depLanding, forKey: "depLanding")
        aCoder.encode(self.deptoAirport, forKey: "deptoAirport")
        aCoder.encode(self.depAmbulancePickup, forKey: "depAmbulancePickup")
        aCoder.encode(self.depArriveHospital, forKey: "depArriveHospital")
        aCoder.encode(self.depLeaveHospital, forKey: "depLeaveHospital")
        aCoder.encode(self.depGiveBy, forKey: "depGiveBy")
        aCoder.encode(self.depRecieveBy, forKey: "depRecieveBy")
        aCoder.encode(self.arriveTakeoff, forKey: "arriveTakeoff")
        aCoder.encode(self.arriveFromAirport, forKey: "arriveFromAirport")
        aCoder.encode(self.arriveLanding, forKey: "arriveLanding")
        aCoder.encode(self.arriveToAirport, forKey: "arriveToAirport")
        aCoder.encode(self.arriveAmbulancePickup, forKey: "arriveAmbulancePickup")
        aCoder.encode(self.arriveHandover, forKey: "arriveHandover")
        aCoder.encode(self.arriveTime, forKey: "arriveTime")
        aCoder.encode(self.arriveGiveBy, forKey: "arriveGiveBy")
        aCoder.encode(self.arriveRecieveBy, forKey: "arriveRecieveBy")
        aCoder.encode(self.painassessmentTypeId, forKey: "painassessmentTypeId")
        aCoder.encode(self.characteristicId, forKey: "characteristicId")
        aCoder.encode(self.characOther, forKey: "characOther")
        aCoder.encode(self.location, forKey: "location")
        aCoder.encode(self.duration, forKey: "duration")
        aCoder.encode(self.frequencyId, forKey: "frequencyId")
        aCoder.encode(self.recieveItems, forKey: "recieveItems")
        aCoder.encode(self.createBy, forKey: "createBy")
        aCoder.encode(self.macId, forKey: "macId")
    }
}
