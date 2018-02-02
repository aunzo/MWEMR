import UIKit
import RxSwift
import RealmSwift
import ObjectMapper
import Alamofire

class caseResultViewModel {
    
    var caseResult = CaseResult()
    let caseUserDefault = UserDefaults.standard
    var username = ""
    let uuid = UIDevice.current.identifierForVendor?.uuidString ?? ""
    let realm = try! Realm()
    var uploadReport = PublishSubject<Int>()
    
    init(){
        
        let profile = CustomerSingleton.sharedInstance.customerProfile
        username = (caseUserDefault.object(forKey: "username") as? String) ?? ""
        if let caseResData = caseUserDefault.data(forKey: "caseResult\(profile.caseId)\(profile.customerId)"),let caseRes = NSKeyedUnarchiver.unarchiveObject(with: caseResData) as? CaseResult {
            caseResult = caseRes
           
        }
       
    }
    
    func prepareCaseResult() -> CaseResult {
        
        if let onBoard = self.caseResult.flightInfo.first {
            onBoard.depTakeoff = self.caseResult.caseVisitDate + " " + onBoard.depTakeoff
            onBoard.depLanding = self.caseResult.caseVisitDate + " " + onBoard.depLanding
            onBoard.depAmbulancePickup = self.caseResult.caseVisitDate + " " + onBoard.depAmbulancePickup
            onBoard.depArriveHospital = self.caseResult.caseVisitDate + " " + onBoard.depArriveHospital
            onBoard.depLeaveHospital = self.caseResult.caseVisitDate + " " + onBoard.depLeaveHospital
            onBoard.arriveTakeoff = self.caseResult.caseVisitDate + " " + onBoard.arriveTakeoff
            onBoard.arriveLanding = self.caseResult.caseVisitDate + " " + onBoard.arriveLanding
            onBoard.arriveAmbulancePickup = self.caseResult.caseVisitDate + " " + onBoard.arriveAmbulancePickup
            onBoard.arriveTime = self.caseResult.caseVisitDate + " " + onBoard.arriveTime
            self.caseResult.flightInfo = [onBoard]
        }
        
        return self.caseResult
    }
    
    func initCaseResult(csr : ConsultResult,cs:[String:Any]){
        caseResult.caseId = (cs["caseId"] as? Int) ?? 0
        caseResult.caseHospital = (cs["hospital"] as? String) ?? "0"
        caseResult.caseDicgnosis = (cs["Dx"] as? String) ?? "0"
        caseResult.caseVisitDate = (cs["visitDate"] as? String) ?? "0"
        caseResult.caseSymptomDate = (cs["symptomDate"] as? String) ?? "0"
        
        var interRes = [InterventionsResult]()
        if let inter = cs["intervention"] as? [[String:AnyObject]] {
            for it in inter {
                let inr = InterventionsResult()
                inr.id = (it["INTERVENTION_ID"] as? Int) ?? 0
                inr.detail = (it["INTERVENTION_DETAIL"] as? String) ?? ""
                inr.date = (it["INTERVENTION_DATE"] as? String) ?? ""
                interRes.append(inr)
            }
        }
        
        caseResult.interventions = interRes
        
        var sumReport = [SummaryReportResult]()
        if let inter = cs["reportFile"] as? [[String:Any]] {
            for it in inter {
                let sr = SummaryReportResult()
                sr.id = (it["REPORT_FILE_ID"] as? Int) ?? 0
                sr.title = (it["REPORT_FILE_NAME"] as? String) ?? ""
                sr.path = (it["REPORT_FILE_PATH"] as? String) ?? ""
                sumReport.append(sr)
            }
        }
        
        caseResult.summaryReport = sumReport
        
        let preflightRes = PreflightResult()
        preflightRes.brief = ""
        preflightRes.sedatedDrung = csr.sedatedDrung
        preflightRes.lastDose = csr.lastDose
        preflightRes.restraintTime = csr.restraintTime
        preflightRes.tubeCuffCheckId = csr.tubeCuffCheckValue
        preflightRes.tubeNo = csr.tubeNo
        preflightRes.tubeFix = csr.tubeFix
        preflightRes.ventialId =  csr.ventialValue
        preflightRes.ventialRate =  csr.ventialRate
        preflightRes.ventialVT =  csr.ventialVT
        preflightRes.ventialFIO2 =  csr.ventialFIO2
        preflightRes.ventialI =  csr.ventialI
        preflightRes.ventialE = csr.ventialE
        preflightRes.ventialPeakFlow = csr.ventialPeakFlow
        preflightRes.ventialPeep = csr.ventialPEEP
        preflightRes.ventialPS = csr.ventialPS
        preflightRes.csvId = csr.csvValue
        preflightRes.neroNSFCheck =  csr.neroNSFCheck == "True" ? true : false
        preflightRes.neroE = csr.neroEValue
        preflightRes.neroM = csr.neroMValue
        preflightRes.neroV = csr.neroVValue
        preflightRes.mpTL = Int(csr.motorPowerTL ) ?? 0
        preflightRes.mpTR = Int(csr.motorPowerTR ) ?? 0
        preflightRes.mpBL = Int(csr.motorPowerBL ) ?? 0
        preflightRes.mpBR = Int(csr.motorPowerBR ) ?? 0
        preflightRes.pupilRTMin = csr.pupilRTMin
        preflightRes.pupilRTTypeId = csr.pupilRTTypeValue
        preflightRes.pupilLTMin = csr.pupilLTMin
        preflightRes.pupilLTTypeId = csr.pupilLTTypeValue
        preflightRes.tempCheck = Int(csr.tempCheck ) ?? 0
        preflightRes.tempValue = csr.tempValue
        preflightRes.tempType =  csr.tempType.first != nil ? csr.tempType.first?.value ?? 0 : 0
        preflightRes.bmMinHG = Int(csr.bmMinHg ) ?? 0
        preflightRes.bmVal1 = Int(csr.bmVal1 ) ?? 0
        preflightRes.bmVal2 = Int(csr.bmVal2 ) ?? 0
        preflightRes.prMin = csr.prMin
        preflightRes.prMinDetail = csr.prMinVal
        preflightRes.o2Sat = Int(csr.o2Sat ) ?? 0
        preflightRes.painScore = csr.painScore
        preflightRes.distalPluseId = csr.distalPulseValue
        preflightRes.distalOther = csr.distalOther
        preflightRes.drainOther = csr.drainOther
        preflightRes.walkId = csr.walkValue
        preflightRes.sitId = csr.sitValue
        preflightRes.eatId = csr.eatValue
        preflightRes.urinationId = csr.urinationValue
        preflightRes.bowelMovmentId =  csr.bowelMovmentValue
        preflightRes.labNSFCheck = csr.labNSFCheck == "True" ? true : false
        preflightRes.hb = csr.hb
        preflightRes.hct = csr.hct
        preflightRes.wbc = csr.wbc
        preflightRes.plt = csr.plt
        preflightRes.pmn = csr.pmn
        preflightRes.lym = csr.lym
        preflightRes.eo = csr.eo
        preflightRes.pt = csr.pt
        preflightRes.ptt = csr.ptt
        preflightRes.inr =  csr.inr
        preflightRes.na = csr.na
        preflightRes.k = csr.k
        preflightRes.cl = csr.cl
        preflightRes.co2 = csr.co2
        preflightRes.bun = csr.bun
        preflightRes.cr = csr.cr
        preflightRes.bs = csr.bs
        preflightRes.cxr = csr.cxr
        preflightRes.ctBrain = csr.ctBrain
        preflightRes.pneumothorax = csr.pneumotholax == "True" ? true : false
        preflightRes.pneumocephalus = csr.pneumocepha == "True" ? true : false
        preflightRes.labOther = csr.labOther
        preflightRes.cspine = csr.cspine
        
        var gaReccords = [GaReccordsResult]()
        var airwayReccords = [AirwayReccordsResult]()
        var deformReccords = [DeformReccordsResult]()
        var drainsReccords = [DrainsReccordsResult]()
        var respReccords = [RespReccordsResult]()
        
        for ga in csr.ga {
            let rec = GaReccordsResult()
            rec.id = ga.value
            gaReccords.append(rec)
        }
        
        for airway in csr.airway {
            let rec = AirwayReccordsResult()
            rec.id = airway.value
            airwayReccords.append(rec)
        }
        
        for deform in csr.deform {
            let rec = DeformReccordsResult()
            rec.id = deform.value
            deformReccords.append(rec)
        }
        
        for drains in csr.drains {
            let rec = DrainsReccordsResult()
            rec.id = drains.value
            drainsReccords.append(rec)
        }
        
        for resp in csr.resp {
            let rec = RespReccordsResult()
            rec.id = resp.value
            rec.lpm = resp.RESP_LPM
            respReccords.append(rec)
        }
        
        preflightRes.gaReccords =  gaReccords
        preflightRes.airwayReccords = airwayReccords
        preflightRes.deformReccords = deformReccords
        preflightRes.drainsReccords = drainsReccords
        preflightRes.respReccords = respReccords
        
        let bagID = realm.objects(MedicalBag.self).first?.bag_id
        caseResult.bagId = bagID ?? 0
        
        caseResult.preflight.append(preflightRes)
        caseResult.flightInfo.append(FlightInfoResult())
        self.saveCaseResutl()
    }
    
    func saveReportFile(sumReport : [SummaryReportResult]){
        caseResult.summaryReport = sumReport
        self.saveCaseResutl()
    }
    
    func saveCaseResutl() {
        let profile = CustomerSingleton.sharedInstance.customerProfile
        let caseResultData = NSKeyedArchiver.archivedData(withRootObject: caseResult)
        caseUserDefault.set(caseResultData, forKey: "caseResult\(profile.caseId)\(profile.customerId)")
        caseUserDefault.synchronize()
        
        
    }
    
    func saveOnboard(data:FlightInfoResult,state:String){
            if let temp = self.caseResult.flightInfo.first {
                if state == "Preflight" {
                    temp.painassessmentTypeId = data.painassessmentTypeId
                    temp.location = data.location
                    temp.duration = data.duration
                    temp.characteristicId = data.characteristicId
                    temp.characOther = data.characOther
                    temp.frequencyId = data.frequencyId
                }else{
                    temp.depTakeoff = data.depTakeoff
                    temp.depFromAirport = data.depFromAirport
                    temp.depLanding = data.depLanding
                    temp.deptoAirport = data.deptoAirport
                    temp.depAmbulancePickup = data.depAmbulancePickup
                    temp.depArriveHospital = data.depArriveHospital
                    temp.depLeaveHospital = data.depLeaveHospital
                    temp.depGiveBy = data.depGiveBy
                    temp.depRecieveBy = data.depRecieveBy
                    temp.arriveTakeoff = data.arriveTakeoff
                    temp.arriveFromAirport = data.arriveFromAirport
                    temp.arriveLanding = data.arriveLanding
                    temp.arriveToAirport = data.arriveToAirport
                    temp.arriveAmbulancePickup = data.arriveAmbulancePickup
                    temp.arriveHandover = data.arriveHandover
                    temp.arriveTime = data.arriveTime
                    temp.arriveGiveBy = data.arriveGiveBy
                    temp.arriveRecieveBy = data.arriveRecieveBy
                    temp.recieveItems = data.recieveItems
                }
                self.caseResult.flightInfo = [temp]
            }
        
        self.saveCaseResutl()
    }
    
    func loadOnboard() -> FlightInfoResult? {
        guard let flightInfo = self.caseResult.flightInfo.first else
        {
            return nil
        }

        return  flightInfo
    }
    
    func savePreflight(data:ConsultResult,otherData:OtherPreflightInfo){
        let profile = CustomerSingleton.sharedInstance.customerProfile
        let intervention = realm.objects(Intervention.self).filter("caseId == \(profile.caseId)")
        var itemIntervention = [InterventionsResult]()
        for inter in intervention {
            let it = InterventionsResult()
            it.detail = inter.intervention
            it.date = inter.date
            itemIntervention.append(it)
        }
        caseResult.interventions = itemIntervention
        
        let flightPerson = realm.objects(FlightPerson.self).filter("caseId == \(profile.caseId)")
        var itemFlightPerson = [FlightPersonsResult]()
        for fp in flightPerson {
            let person = FlightPersonsResult()
            if let position = realm.objects(MasterData.self).filter("name == '\(fp.position)'").first {
                person.id = position.masterID
            }
            
            person.name = fp.name
            itemFlightPerson.append(person)
        }
        caseResult.flightPerson = itemFlightPerson
        
        let masterData = realm.objects(MasterData.self)
        let csvValue = masterData.filter("name == '\(data.csvDisplay)' && fieldID == 6").first?.masterID  ?? 54
        let neroE = masterData.filter("name == '\(data.neroEDisplay)' && fieldID == 38").first?.masterID ?? 48
        let neroM = masterData.filter("name == '\(data.neroMDisplay)' && fieldID == 39").first?.masterID ?? 41
        let neroV = masterData.filter("name == '\(data.neroVDisplay)' && fieldID == 40").first?.masterID ?? 34
        var tempTypeDisplay = ""
        if data.tempType.count != 0 {
            tempTypeDisplay = data.tempType[0].display
        }
        let tempType = masterData.filter("name == '\(tempTypeDisplay)' && fieldID == 43").first?.masterID ?? 26
        let walk = masterData.filter("name == '\(data.walkDisplay)' && fieldID == 10").first?.masterID ?? 128
        let sit = masterData.filter("name == '\(data.sitDisplay)' && fieldID == 11").first?.masterID ?? 124
        let eat = masterData.filter("name == '\(data.eatDisplay)' && fieldID == 12").first?.masterID ?? 120
        let urination = masterData.filter("name == '\(data.urinationDisplay)' && fieldID == 13").first?.masterID ?? 116
        let bowel = masterData.filter("name == '\(data.bowelMovmentDisplay)' && fieldID == 47").first?.masterID ?? 188 
        
        let preflightRes = PreflightResult()
        
        var gaReccords = [GaReccordsResult]()
        var airwayReccords = [AirwayReccordsResult]()
        var deformReccords = [DeformReccordsResult]()
        var drainsReccords = [DrainsReccordsResult]()
        var respReccords = [RespReccordsResult]()
        
        for ga in data.ga {
            let rec = GaReccordsResult()
            rec.id = ga.value
            gaReccords.append(rec)
        }
        
        for airway in data.airway {
            let rec = AirwayReccordsResult()
            rec.id = airway.value
            airwayReccords.append(rec)
        }
        
        for deform in data.deform {
            let rec = DeformReccordsResult()
            rec.id = deform.value
            deformReccords.append(rec)
        }
        
        for drains in data.drains {
            let rec = DrainsReccordsResult()
            rec.id = drains.value
            drainsReccords.append(rec)
        }
        
        for resp in data.resp {
            let rec = RespReccordsResult()
            rec.id = resp.value
            rec.lpm = resp.RESP_LPM
            respReccords.append(rec)
        }
        
        preflightRes.gaReccords =  gaReccords
        preflightRes.airwayReccords = airwayReccords
        preflightRes.deformReccords = deformReccords
        preflightRes.drainsReccords = drainsReccords
        preflightRes.respReccords = respReccords

        preflightRes.brief = otherData.brief
        preflightRes.sedatedDrung = data.sedatedDrung
        preflightRes.lastDose = data.lastDose
        preflightRes.restraintTime = data.restraintTime
        preflightRes.tubeCuffCheckId = data.tubeCuffCheckValue
        preflightRes.tubeNo = data.tubeNo
        preflightRes.tubeFix = data.tubeFix
        preflightRes.ventialId =  data.ventialValue
        preflightRes.ventialRate =  data.ventialRate
        preflightRes.ventialVT =  data.ventialVT
        preflightRes.ventialFIO2 =  data.ventialFIO2
        preflightRes.ventialI =  data.ventialI
        preflightRes.ventialE = data.ventialE
        preflightRes.ventialPeakFlow = data.ventialPeakFlow
        preflightRes.ventialPeep = data.ventialPEEP
        preflightRes.ventialPS = data.ventialPS
        preflightRes.csvId = csvValue
        preflightRes.neroNSFCheck =  data.neroNSFCheck == "True" ? true : false
        preflightRes.neroE = neroE
        preflightRes.neroM = neroM
        preflightRes.neroV = neroV
        preflightRes.mpTL = Int(data.motorPowerTL ) ?? 0
        preflightRes.mpTR = Int(data.motorPowerTR ) ?? 0
        preflightRes.mpBL = Int(data.motorPowerBL ) ?? 0
        preflightRes.mpBR = Int(data.motorPowerBR ) ?? 0
        preflightRes.pupilRTMin = data.pupilRTMin
        preflightRes.pupilRTTypeId = data.pupilRTTypeValue
        preflightRes.pupilLTMin = data.pupilLTMin
        preflightRes.pupilLTTypeId = data.pupilLTTypeValue
        preflightRes.tempCheck = Int(data.tempCheck ) ?? 0
        preflightRes.tempValue = data.tempValue
        preflightRes.tempType =  tempType
        preflightRes.bmMinHG = Int(data.bmMinHg ) ?? 0
        preflightRes.bmVal1 = Int(data.bmVal1 ) ?? 0
        preflightRes.bmVal2 = Int(data.bmVal2 ) ?? 0
        preflightRes.prMin = data.prMin
        preflightRes.prMinDetail = data.prMinVal
        preflightRes.o2Sat = Int(data.o2Sat ) ?? 0
        preflightRes.painScore = data.painScore
        preflightRes.distalPluseId = data.distalPulseValue
        preflightRes.distalOther = data.distalOther
        preflightRes.drainOther = data.drainOther
        preflightRes.walkId = walk
        preflightRes.sitId = sit
        preflightRes.eatId = eat
        preflightRes.urinationId = urination
        preflightRes.bowelMovmentId =  bowel
        preflightRes.labNSFCheck = data.labNSFCheck == "True" ? true : false
        preflightRes.hb = data.hb
        preflightRes.hct = data.hct
        preflightRes.wbc = data.wbc
        preflightRes.plt = data.plt
        preflightRes.pmn = data.pmn
        preflightRes.lym = data.lym
        preflightRes.eo = data.eo
        preflightRes.pt = data.pt
        preflightRes.ptt = data.ptt
        preflightRes.inr =  data.inr
        preflightRes.na = data.na
        preflightRes.k = data.k
        preflightRes.cl = data.cl
        preflightRes.co2 = data.co2
        preflightRes.bun = data.bun
        preflightRes.cr = data.cr
        preflightRes.bs = data.bs
        preflightRes.cxr = data.cxr
        preflightRes.ctBrain = data.ctBrain
        preflightRes.pneumothorax = data.pneumotholax == "True" ? true : false
        preflightRes.pneumocephalus = data.pneumocepha == "True" ? true : false
        preflightRes.labOther = data.labOther
        preflightRes.cspine = data.cspine
        preflightRes.physicalOther = otherData.physicalOther
        preflightRes.currentTreatment = otherData.currentTreatment
        preflightRes.escotComment = otherData.escotComment
        
        
        let aircraftId = masterData.filter("name == '\(otherData.aircraftName)' && fieldID == 48").first?.masterID
        self.caseResult.aircraftId = aircraftId ?? 0
        caseResult.caseHospital = otherData.caseHospital
        caseResult.caseVisitDate = otherData.caseVisitDate
        caseResult.caseSymptomDate = otherData.caseSymptomDate
        caseResult.caseDicgnosis = otherData.caseDicgnosis
        caseResult.preflight = [preflightRes]
        self.saveCaseResutl()
    }
    
    func loadPreflight() -> (caseResult:CaseResult,other:OtherPreflightInfo) {
        let firstAircarft = realm.objects(MasterData.self).filter("fieldID == 48").first?.name ?? "Select Aircarft"
        let aircraftName = realm.objects(MasterData.self).filter("masterID == \(self.caseResult.aircraftId)").first?.name ?? firstAircarft
        
        let otherData = OtherPreflightInfo()
        
        otherData.caseHospital = caseResult.caseHospital
        otherData.caseVisitDate = caseResult.caseVisitDate
        otherData.caseSymptomDate = caseResult.caseSymptomDate
        otherData.aircraftName = aircraftName
        otherData.caseDicgnosis = caseResult.caseDicgnosis

        
        return (caseResult,otherData)
    }
    
    func saveMedicalUsing(){
        let profile = CustomerSingleton.sharedInstance.customerProfile
        let items = realm.objects(MedicalUsing.self).filter("caseId == \(profile.caseId)")
        var itemMedication = [MedicationsResult]()
        var itemEquipment = [EquipmentsResult]()
        
        for i in items {
            if i.typeMed == "Medication" { 
                let med = MedicationsResult()
                med.id = i.itemId
                med.note = i.note
                med.balance = i.amount
                itemMedication.append(med)
            }else{
                let equip = EquipmentsResult()
                equip.id = i.itemId
                equip.note = i.note
                itemEquipment.append(equip)
            }
        }
        
        caseResult.medication = itemMedication
        caseResult.equipment = itemEquipment
        self.saveCaseResutl()
    }
    
    func saveProgessions(){
        let profile = CustomerSingleton.sharedInstance.customerProfile
        let items = realm.objects(Progression.self).filter("caseId == \(profile.caseId)")
        var item = [ProgressionsResult]()
        for i in items {
            let progress = ProgressionsResult()
            progress.time = caseResult.caseVisitDate + " " + i.time
            progress.gcs = i.cgs
            progress.pupil = i.pupil
            progress.bt = i.bt
            progress.pr = i.pr
            progress.rr = i.rr
            progress.bp = i.bp
            progress.spo2 = i.spo2
            progress.etco2 = i.etco2
            progress.ekg = i.ekg
            progress.painScore = i.painScore
            progress.input = i.input
            progress.output = i.output
            progress.treatment = i.tm
            progress.remark = i.remark
            item.append(progress)
        }
        caseResult.progression = item
        caseUserDefault.synchronize()
        self.saveCaseResutl()
    }
    
    func removeCaseResult() {
        let profile = CustomerSingleton.sharedInstance.customerProfile
        let profileCustomer = "\(profile.caseId)\(profile.customerId)"
        caseUserDefault.removeObject(forKey: "otherData\(profileCustomer)")
        caseUserDefault.removeObject(forKey: "caseResult\(profileCustomer)")
        let predicate = "caseId == \(profile.caseId)"
        let progresson = realm.objects(Progression.self).filter(predicate)
        let medicalUsing = realm.objects(MedicalUsing.self).filter(predicate)
        let flightPerson = realm.objects(FlightPerson.self).filter(predicate)
        let intervention = realm.objects(Intervention.self).filter(predicate)
        let report = realm.objects(SummaryReport.self).filter(predicate)
        
        let itemReport = self.realm.objects(SummaryReport.self).filter("caseId == \(profile.caseId)")
        for item in itemReport {
            let fileManager = FileManager.default
            let documentDirectoryURLs = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
            
            if let filePath = documentDirectoryURLs.first?.appendingPathComponent(item.path ).path {
                self.removeFile(path: filePath)
            }
        }
        
        try! realm.write {
            realm.delete(progresson)
            realm.delete(medicalUsing)
            realm.delete(flightPerson)
            realm.delete(intervention)
            realm.delete(report)
        }
    }
    
    func saveSuggestion(suggestion:[SuggestionsResult],comment:String) {
        caseResult.suggestion = suggestion
        caseResult.suggestionComment = comment
        self.saveCaseResutl()
    }
    
    func clearSuggestion() {
        caseResult.suggestion = []
        self.saveCaseResutl()
    }
    
    func loadSuggestion() -> (suggestion:[SuggestionsResult],comment:String) {
        return (caseResult.suggestion,caseResult.suggestionComment)
    }
    
    func uploadReportFile(index:Int){
        let profile = CustomerSingleton.sharedInstance.customerProfile
        let itemFind = self.realm.objects(SummaryReport.self).filter("caseId == \(profile.caseId) AND isUpload == true")
        if index < itemFind.count {
            let item = itemFind[index]
            let fileName = item.path
            let fileManager = FileManager.default
            let documentDirectoryURLs = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
            
            if let filePath = documentDirectoryURLs.first?.appendingPathComponent(fileName ).path {
                let createBy = (UserDefaults.standard.object(forKey: "username") as? String) ?? ""
                let macId = UIDevice.current.identifierForVendor?.uuidString ?? ""
                let param = [
                    "REPORT_FILE_NAME":item.title,
                    "Case_CASE_ID":profile.caseId,
                    "CREATE_BY":createBy,
                    "UPDATE_BY":createBy,
                    "MAC_ID":macId,
                    "path":item.path] as [String : Any]
                if item.isUpload {
                    Alamofire.upload(
                        multipartFormData: { multipartFormData in
                            let image = UIImage(contentsOfFile: filePath)
                            
                            for (key, value) in param {
                                if key == "path" {
                                    if  let imageData = UIImageJPEGRepresentation(image!, 0.6) {
                                        multipartFormData.append(imageData, withName: "file", fileName: value as! String, mimeType: "image/png")
                                    }
                                }else{
                                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                                }
                                
                            }
                        },
                        to: Constant.uploadReport,
                        encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                
                                upload.responseString(completionHandler: { (response) in
                                    if response.result.value == "Success" {
                                        print("Success")
                                        self.uploadReport.onNext(index + 1)
                                        self.removeFile(path: filePath)
                                    }else{
                                        print("error")
                                        let error = NSError(domain: "", code: 500, userInfo: nil)
                                        self.uploadReport.onError(error)
                                        
                                    }
                                })
                                
                                
                            case .failure(let encodingError):
                                print(encodingError)
                                self.uploadReport.onError(encodingError)
                            }
                        }
                    )
                    
                }
                
            }
        }else{
            self.uploadReport.onCompleted()
            let itemReport = self.realm.objects(SummaryReport.self).filter("caseId == \(profile.caseId) AND isUpload == false")
            for item in itemReport {
                let fileManager = FileManager.default
                let documentDirectoryURLs = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
                
                if let filePath = documentDirectoryURLs.first?.appendingPathComponent(item.path ).path {
                    self.removeFile(path: filePath)
                }
            }
        }
    }

    func removeFile(path:String) {
        do {
            let fileManager = FileManager.default
            try fileManager.removeItem(atPath: path)
        }catch let error as NSError {
            print("ERROR: \(error)")
        }
    }
}
