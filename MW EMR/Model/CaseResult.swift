import ObjectMapper

class CaseResult: NSObject, NSCoding , Mappable {
    
    var caseId = 0
    var caseHospital = ""
    var caseVisitDate = ""
    var caseDicgnosis = ""
    var caseSymptomDate = ""
    var bagId = 0
    var aircraftId = 0
    var createBy = (UserDefaults.standard.object(forKey: "username") as? String) ?? ""
    var macId = UIDevice.current.identifierForVendor?.uuidString ?? ""
    var suggestionComment = ""
    var interventions = [InterventionsResult]()
    var equipment = [EquipmentsResult]()
    var medication = [MedicationsResult]()
    var flightInfo = [FlightInfoResult]()
    var progression = [ProgressionsResult]()
    var suggestion = [SuggestionsResult]()
    var flightPerson = [FlightPersonsResult]()
    var preflight = [PreflightResult]()
    var summaryReport = [SummaryReportResult]()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        caseId <- map["CASE_ID"]
        caseHospital <- map["CASE_HOSPITAL"]
        caseVisitDate <- map["CASE_VISIT_DATE"]
        caseDicgnosis <- map["CASE_DICGNOSIS"]
        caseSymptomDate <- map["CASE_SYMPTOM_DATE"]
        bagId <- map["Bag_BAG_ID"]
        aircraftId <- map["MasterData_AIRCRAFT_ID"]
        createBy <- map["CREATE_BY"]
        macId <- map["MAC_ID"]
        suggestionComment <- map["SUGGESSION_COMMENT"]
        interventions <- map["Interventions"]
        summaryReport <- map["reportFile"]
        equipment <- map["EquipmentUses"]
        medication <- map["MedicationHistories"]
        flightInfo <- map["FlightInfomations"]
        progression <- map["Progessions"]
        suggestion <- map["Suggessions"]
        flightPerson <- map["FlightPersons"]
        preflight <- map["PreFilgthForms"]
    }
    
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        caseId = aDecoder.decodeInteger(forKey: "CASE_ID")
        caseHospital = aDecoder.decodeObject(forKey: "CASE_HOSPITAL") as! String
        caseVisitDate = aDecoder.decodeObject(forKey: "CASE_VISIT_DATE") as! String
        caseDicgnosis = aDecoder.decodeObject(forKey: "CASE_DICGNOSIS") as! String
        caseSymptomDate = aDecoder.decodeObject(forKey: "CASE_SYMPTOM_DATE") as! String
        bagId = aDecoder.decodeInteger(forKey: "Bag_BAG_ID")
        aircraftId = aDecoder.decodeInteger(forKey: "MasterData_AIRCRAFT_ID")
        createBy = aDecoder.decodeObject(forKey: "CREATE_BY") as! String
        macId = aDecoder.decodeObject(forKey: "MAC_ID") as! String
        suggestionComment = aDecoder.decodeObject(forKey: "SUGGESSION_COMMENT") as! String
        interventions = aDecoder.decodeObject(forKey: "intervention") as! [InterventionsResult]
        summaryReport = aDecoder.decodeObject(forKey: "reportFile") as! [SummaryReportResult]
        equipment = aDecoder.decodeObject(forKey: "EquipmentUses") as! [EquipmentsResult]
        medication = aDecoder.decodeObject(forKey: "MedicationHistories") as! [MedicationsResult]
        flightInfo = aDecoder.decodeObject(forKey: "FlightInfomations") as! [FlightInfoResult]
        progression = aDecoder.decodeObject(forKey: "Progessions") as! [ProgressionsResult]
        suggestion = aDecoder.decodeObject(forKey: "Suggessions") as! [SuggestionsResult]
        flightPerson = aDecoder.decodeObject(forKey: "FlightPersons") as! [FlightPersonsResult]
        preflight = aDecoder.decodeObject(forKey: "PreFilgthForms") as! [PreflightResult]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.caseId, forKey: "CASE_ID")
        aCoder.encode(self.caseHospital, forKey: "CASE_HOSPITAL")
        aCoder.encode(self.caseVisitDate, forKey: "CASE_VISIT_DATE")
        aCoder.encode(self.caseDicgnosis, forKey: "CASE_DICGNOSIS")
        aCoder.encode(self.caseSymptomDate, forKey: "CASE_SYMPTOM_DATE")
        aCoder.encode(self.bagId, forKey: "Bag_BAG_ID")
        aCoder.encode(self.aircraftId, forKey: "MasterData_AIRCRAFT_ID")
        aCoder.encode(self.createBy, forKey: "CREATE_BY")
        aCoder.encode(self.macId, forKey: "MAC_ID")
        aCoder.encode(self.suggestionComment, forKey: "SUGGESSION_COMMENT")
        aCoder.encode(self.interventions, forKey: "intervention")
        aCoder.encode(self.summaryReport, forKey: "reportFile")
        aCoder.encode(self.equipment, forKey: "EquipmentUses")
        aCoder.encode(self.medication, forKey: "MedicationHistories")
        aCoder.encode(self.flightInfo, forKey: "FlightInfomations")
        aCoder.encode(self.progression, forKey: "Progessions")
        aCoder.encode(self.suggestion, forKey: "Suggessions")
        aCoder.encode(self.flightPerson, forKey: "FlightPersons")
        aCoder.encode(self.preflight, forKey: "PreFilgthForms")
        
    }
}

























