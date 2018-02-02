import ObjectMapper
class PreflightResult: NSObject,NSCoding, Mappable {
    
    var bmMinHG = 0
    var bmVal1 = 0
    var bmVal2 = 0
    var bs = ""
    var bun = ""
    var cl = ""
    var co2 = ""
    var cr = ""
    var ctBrain = ""
    var cxr = ""
    var distalOther = ""
    var drainOther = ""
    var eo = ""
    var hb = ""
    var hct = ""
    var inr = ""
    var k = ""
    var labNSFCheck = false
    var labOther = ""
    var lastDose = ""
    var lym = ""
    var mpBL = 0
    var mpBR = 0
    var mpTL = 0
    var mpTR = 0
    var na = ""
    var neroNSFCheck = false
    var o2Sat = 0
    var painScore = ""
    var plt = ""
    var pmn = ""
    var prMin = ""
    var prMinDetail = ""
    var pt = ""
    var ptt = ""
    var pupilRT = ""
    var pupilLT = ""
    var restraintTime = ""
    var tempCheck = 0
    var tempValue = ""
    var tubeFix = ""
    var tubeNo = ""
    var ventialE = ""
    var ventialFIO2 = ""
    var ventialI = ""
    var ventialPeep = ""
    var ventialPS = ""
    var ventialRate = ""
    var ventialVT = ""
    var ventialPeakFlow = ""
    var wbc = ""
    var bowelMovmentId = 0
    var ventialId = 0
    var csvId = 0
    var neroE = 0
    var neroM = 0
    var neroV = 0
    var pupilRTTypeId = 0
    var pupilLTTypeId = 0
    var distalPluseId = 0
    var walkId = 0
    var sitId = 0
    var eatId = 0
    var urinationId = 0
    var gaReccords = [GaReccordsResult]()
    var airwayReccords = [AirwayReccordsResult]()
    var respReccords = [RespReccordsResult]()
    var deformReccords = [DeformReccordsResult]()
    var drainsReccords = [DrainsReccordsResult]()
    var tempType = 0
    var cspine = ""
    var brief = ""
    var sedatedDrung = ""
    var tubeCuffCheckId = 0
    var pneumothorax = false
    var pneumocephalus = false
    var physicalOther = ""
    var currentTreatment = ""
    var escotComment = ""
    var createBy = (UserDefaults.standard.object(forKey: "username") as? String) ?? ""
    var macId = UIDevice.current.identifierForVendor?.uuidString ?? ""
    var pupilRTMin = ""
    var pupilLTMin = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    // Mappable
    func mapping(map: Map) {
        brief <- map["PREFLIGHT_BRIEF"]
        sedatedDrung <- map["PREFLIGHT_SEDATES_DRUNG"]
        lastDose <- map["PREFLIGHT_LAST_DOSE"]
        restraintTime <- map["PREFLIGHT_RESTRAINT_TIME"]
        tubeCuffCheckId <- map["MasterData_TUBE_CUFF_CHECK_ID"]
        tubeNo <- map["PREFLIGHT_TUBE_NO"]
        tubeFix <- map["PREFLIGHT_TUBE_FIX"]
        ventialId <- map["MasterData_VENTIAL_ID"]
        ventialRate <- map["PREFLIGHT_VENTIAL_RATE"]
        ventialVT <- map["PREFLIGHT_VENTIAL_VT"]
        ventialFIO2 <- map["PREFLIGHT_VENTIAL_FIO2"]
        ventialI <- map["PREFLIGHT_VENTIAL_I"]
        ventialE <- map["PREFLIGHT_VENTIAL_E"]
        ventialPeakFlow <- map["PREFLIGHT_VENTIAL_PEAK_FLOW"]
        ventialPeep <- map["PREFLIGHT_VENTIAL_PEEP"]
        ventialPS <- map["PREFLIGHT_VENTIAL_PS"]
        csvId <- map["MasterData_CSV_ID"]
        neroNSFCheck <- map["PREFLIGHT_NERO_NSF_CHECK"]
        neroE <- map["MasterData_NERO_E"]
        neroM <- map["MasterData_NERO_M"]
        neroV <- map["MasterData_NERO_V"]
        mpTL <- map["PREFLIGHT_MP_TL"]
        mpTR <- map["PREFLIGHT_MP_TR"]
        mpBL <- map["PREFLIGHT_MP_BL"]
        mpBR <- map["PREFLIGHT_MP_BR"]
        pupilRT <- map["PREFLIGHT_PUPIL_RT"]
        pupilRTTypeId <- map["MasterData_PUPIL_RT_TYPE_ID"]
        pupilRTMin <- map["PREFLIGHT_PUPIL_RT_MIN"]
        pupilLT <- map["PREFLIGHT_PUPIL_LT"]
        pupilLTTypeId <- map["MasterData_PUPIL_LT_TYPE_ID"]
        pupilLTMin <- map["PREFLIGHT_PUPIL_LT_MIN"]
        tempCheck <- map["PREFLIGHT_TEMP_CHECK"]
        tempValue <- map["PREFLIGHT_TEMP_VALUE"]
        tempType <- map["PREFLIGHT_TEMP_TYPE"]
        bmMinHG <- map["PREFLIGHT_BM_MIN_HG"]
        bmVal1 <- map["PREFLIGHT_BM_VAL1"]
        bmVal2 <- map["PREFLIGHT_BM_VAL2"]
        prMin <- map["PREFLIGHT_PR_MIN"]
        prMinDetail <- map["PREFLIGHT_PR_MIN_DETAIL"]
        o2Sat <- map["PREFLIGHT_O2_SAT"]
        painScore <- map["PREFLIGHT_PAIN_SCORE"]
        distalPluseId <- map["MasterData_DISTAL_PULSE_ID"]
        distalOther <- map["PREFLIGHT_DISTAL_OTHER"]
        drainOther <- map["PREFLIGHT_DRAIN_OTHER"]
        walkId <- map["MasterData_WALK_ID"]
        sitId <- map["MasterData_SIT_ID"]
        eatId <- map["MasterData_EAT_ID"]
        urinationId <- map["MasterData_URINATION_ID"]
        bowelMovmentId <- map["MasterData_BOWEL_MOVMENT_ID"]
        labNSFCheck <- map["PREFLIGHT_LAB_NSF_CHECK"]
        hb <- map["PREFLIGHT_HB"]
        hct <- map["PREFLIGHT_HCT"]
        wbc <- map["PREFLIGHT_WBC"]
        plt <- map["PREFLIGHT_PLT"]
        pmn <- map["PREFLIGHT_PMN"]
        lym <- map["PREFLIGHT_LYM"]
        eo <- map["PREFLIGHT_EO"]
        pt <- map["PREFLIGHT_PT"]
        ptt <- map["PREFLIGHT_PTT"]
        inr <- map["PREFLIGHT_INR"]
        na <- map["PREFLIGHT_NA"]
        k <- map["PREFLIGHT_K"]
        cl <- map["PREFLIGHT_CL"]
        co2 <- map["PREFLIGHT_CO2"]
        bun <- map["PREFLIGHT_BUN"]
        cr <- map["PREFLIGHT_CR"]
        bs <- map["PREFLIGHT_BS"]
        cxr <- map["PREFLIGHT_CXR"]
        ctBrain <- map["PREFLIGHT_CT_BRAIN"]
        pneumothorax <- map["PREFLIGHT_PNEUMOTHORAX"]
        pneumocephalus <- map["PREFLIGHT_PNEUMOCEPHALUS"]
        labOther <- map["PREFLIGHT_LAB_OTHER"]
        physicalOther <- map["PREFLIGHT_PHYSICAL_OTHER"]
        currentTreatment <- map["PREFLIGHT_CURRENT_TREATMENT"]
        escotComment <- map["PREFLIGHT_ESCOT_COMMENT"]
        cspine <- map["PREFLIGHT_CSPINE"]
        createBy <- map["CREATE_BY"]
        macId <- map["MAC_ID"]
        gaReccords <- map["GAReccords"]
        airwayReccords <- map["AirwayReccords"]
        deformReccords <- map["DeformReccords"]
        drainsReccords <- map["DrainsReccords"]
        respReccords <- map["respReccords"]
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        self.brief = aDecoder.decodeObject(forKey: "brief") as! String
        self.sedatedDrung = aDecoder.decodeObject(forKey: "sedatedDrung") as! String
        self.lastDose = aDecoder.decodeObject(forKey: "lastDose") as! String
        self.restraintTime = aDecoder.decodeObject(forKey: "restraintTime") as! String
        self.tubeCuffCheckId = aDecoder.decodeInteger(forKey: "tubeCuffCheckId")
        self.tubeNo = aDecoder.decodeObject(forKey: "tubeNo") as! String
        self.tubeFix = aDecoder.decodeObject(forKey: "tubeFix") as! String
        self.ventialId = aDecoder.decodeInteger(forKey: "ventialId")
        self.ventialRate = aDecoder.decodeObject(forKey: "ventialRate") as! String
        self.ventialVT = aDecoder.decodeObject(forKey: "ventialVT") as! String
        self.ventialFIO2 = aDecoder.decodeObject(forKey: "ventialFIO2") as! String
        self.ventialI = aDecoder.decodeObject(forKey: "ventialI") as! String
        self.ventialE = aDecoder.decodeObject(forKey: "ventialE") as! String
        self.ventialPeakFlow = aDecoder.decodeObject(forKey: "ventialPeakFlow") as! String
        self.ventialPeep = aDecoder.decodeObject(forKey: "ventialPeep") as! String
        self.ventialPS = aDecoder.decodeObject(forKey: "ventialPS") as! String
        self.csvId = aDecoder.decodeInteger(forKey: "csvId")
        self.neroNSFCheck = aDecoder.decodeBool(forKey: "neroNSFCheck")
        self.neroE = aDecoder.decodeInteger(forKey: "neroE")
        self.neroM = aDecoder.decodeInteger(forKey: "neroM")
        self.neroV = aDecoder.decodeInteger(forKey: "neroV")
        self.mpTL = aDecoder.decodeInteger(forKey: "mpTL")
        self.mpTR = aDecoder.decodeInteger(forKey: "mpTR")
        self.mpBL = aDecoder.decodeInteger(forKey: "mpBL")
        self.mpBR = aDecoder.decodeInteger(forKey: "mpBR")
        self.pupilRT = aDecoder.decodeObject(forKey: "pupilRT") as! String
        self.pupilRTTypeId = aDecoder.decodeInteger(forKey: "pupilRTTypeId")
        self.pupilRTMin = aDecoder.decodeObject(forKey: "pupilRTMin") as! String
        self.pupilLT = aDecoder.decodeObject(forKey: "pupilLT") as! String
        self.pupilLTTypeId = aDecoder.decodeInteger(forKey: "pupilLTTypeId")
        self.pupilLTMin = aDecoder.decodeObject(forKey: "pupilLTMin") as! String
        self.tempCheck = aDecoder.decodeInteger(forKey: "tempCheck")
        self.tempValue = aDecoder.decodeObject(forKey: "tempValue") as! String
        self.tempType = aDecoder.decodeInteger(forKey: "tempType")
        self.bmMinHG = aDecoder.decodeInteger(forKey: "bmMinHG")
        self.bmVal1 = aDecoder.decodeInteger(forKey: "bmVal1")
        self.bmVal2 = aDecoder.decodeInteger(forKey: "bmVal2")
        self.prMin = aDecoder.decodeObject(forKey: "prMin") as! String
        self.prMinDetail = aDecoder.decodeObject(forKey: "prMinDetail") as! String
        self.o2Sat = aDecoder.decodeInteger(forKey: "o2Sat")
        self.painScore = aDecoder.decodeObject(forKey: "painScore") as! String
        self.distalPluseId = aDecoder.decodeInteger(forKey: "distalPluseId")
        self.distalOther = aDecoder.decodeObject(forKey: "distalOther") as! String
        self.drainOther = aDecoder.decodeObject(forKey: "drainOther") as! String
        self.walkId = aDecoder.decodeInteger(forKey: "walkId")
        self.sitId = aDecoder.decodeInteger(forKey: "sitId")
        self.eatId = aDecoder.decodeInteger(forKey: "eatId")
        self.urinationId = aDecoder.decodeInteger(forKey: "urinationId")
        self.bowelMovmentId = aDecoder.decodeInteger(forKey: "bowelMovmentId")
        self.labNSFCheck = aDecoder.decodeBool(forKey: "labNSFCheck")
        self.hb = aDecoder.decodeObject(forKey: "hb") as! String
        self.hct = aDecoder.decodeObject(forKey: "hct") as! String
        self.wbc = aDecoder.decodeObject(forKey: "wbc") as! String
        self.plt = aDecoder.decodeObject(forKey: "plt") as! String
        self.pmn = aDecoder.decodeObject(forKey: "pmn") as! String
        self.lym = aDecoder.decodeObject(forKey: "lym") as! String
        self.eo = aDecoder.decodeObject(forKey: "eo") as! String
        self.pt = aDecoder.decodeObject(forKey: "pt") as! String
        self.ptt = aDecoder.decodeObject(forKey: "ptt") as! String
        self.inr = aDecoder.decodeObject(forKey: "inr") as! String
        self.na = aDecoder.decodeObject(forKey: "na") as! String
        self.k = aDecoder.decodeObject(forKey: "k") as! String
        self.cl = aDecoder.decodeObject(forKey: "cl") as! String
        self.co2 = aDecoder.decodeObject(forKey: "co2") as! String
        self.bun = aDecoder.decodeObject(forKey: "bun") as! String
        self.cr = aDecoder.decodeObject(forKey: "cr") as! String
        self.bs = aDecoder.decodeObject(forKey: "bs") as! String
        self.cxr = aDecoder.decodeObject(forKey: "cxr") as! String
        self.ctBrain = aDecoder.decodeObject(forKey: "ctBrain") as! String
        self.pneumothorax = aDecoder.decodeBool(forKey: "pneumothorax")
        self.pneumocephalus = aDecoder.decodeBool(forKey: "pneumocephalus")
        self.labOther = aDecoder.decodeObject(forKey: "labOther") as! String
        self.physicalOther = aDecoder.decodeObject(forKey: "physicalOther") as! String
        self.currentTreatment = aDecoder.decodeObject(forKey: "currentTreatment") as! String
        self.escotComment = aDecoder.decodeObject(forKey: "escotComment") as! String
        self.cspine = aDecoder.decodeObject(forKey: "cspine") as! String
        self.gaReccords = aDecoder.decodeObject(forKey: "gaReccords") as! [GaReccordsResult]
        self.airwayReccords = aDecoder.decodeObject(forKey: "airwayReccords") as! [AirwayReccordsResult]
        self.deformReccords = aDecoder.decodeObject(forKey: "deformReccords") as! [DeformReccordsResult]
        self.drainsReccords = aDecoder.decodeObject(forKey: "drainsReccords") as! [DrainsReccordsResult]
        self.respReccords = aDecoder.decodeObject(forKey: "respReccords") as! [RespReccordsResult]
        self.createBy = aDecoder.decodeObject(forKey: "createBy") as! String
        self.macId = aDecoder.decodeObject(forKey: "macId") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.brief, forKey: "brief")
        aCoder.encode(self.sedatedDrung, forKey: "sedatedDrung")
        aCoder.encode(self.lastDose, forKey: "lastDose")
        aCoder.encode(self.restraintTime, forKey: "restraintTime")
        aCoder.encode(self.tubeCuffCheckId, forKey: "tubeCuffCheckId")
        aCoder.encode(self.tubeNo, forKey: "tubeNo")
        aCoder.encode(self.tubeFix, forKey: "tubeFix")
        aCoder.encode(self.ventialId, forKey: "ventialId")
        aCoder.encode(self.ventialRate, forKey: "ventialRate")
        aCoder.encode(self.ventialVT, forKey: "ventialVT")
        aCoder.encode(self.ventialFIO2, forKey: "ventialFIO2")
        aCoder.encode(self.ventialI, forKey: "ventialI")
        aCoder.encode(self.ventialE, forKey: "ventialE")
        aCoder.encode(self.ventialPeakFlow, forKey: "ventialPeakFlow")
        aCoder.encode(self.ventialPeep, forKey: "ventialPeep")
        aCoder.encode(self.ventialPS, forKey: "ventialPS")
        aCoder.encode(self.csvId, forKey: "csvId")
        aCoder.encode(self.neroNSFCheck, forKey: "neroNSFCheck")
        aCoder.encode(self.neroE, forKey: "neroE")
        aCoder.encode(self.neroM, forKey: "neroM")
        aCoder.encode(self.neroV, forKey: "neroV")
        aCoder.encode(self.mpTL, forKey: "mpTL")
        aCoder.encode(self.mpTR, forKey: "mpTR")
        aCoder.encode(self.mpBL, forKey: "mpBL")
        aCoder.encode(self.mpBR, forKey: "mpBR")
        aCoder.encode(self.pupilRT, forKey: "pupilRT")
        aCoder.encode(self.pupilRTTypeId, forKey: "pupilRTTypeId")
        aCoder.encode(self.pupilRTMin, forKey: "pupilRTMin")
        aCoder.encode(self.pupilLT, forKey: "pupilLT")
        aCoder.encode(self.pupilLTTypeId, forKey: "pupilLTTypeId")
        aCoder.encode(self.pupilLTMin, forKey: "pupilLTMin")
        aCoder.encode(self.tempCheck, forKey: "tempCheck")
        aCoder.encode(self.tempValue, forKey: "tempValue")
        aCoder.encode(self.tempType, forKey: "tempType")
        aCoder.encode(self.bmMinHG, forKey: "bmMinHG")
        aCoder.encode(self.bmVal1, forKey: "bmVal1")
        aCoder.encode(self.bmVal2, forKey: "bmVal2")
        aCoder.encode(self.prMin, forKey: "prMin")
        aCoder.encode(self.prMinDetail, forKey: "prMinDetail")
        aCoder.encode(self.o2Sat, forKey: "o2Sat")
        aCoder.encode(self.painScore, forKey: "painScore")
        aCoder.encode(self.distalPluseId, forKey: "distalPluseId")
        aCoder.encode(self.distalOther, forKey: "distalOther")
        aCoder.encode(self.drainOther, forKey: "drainOther")
        aCoder.encode(self.walkId, forKey: "walkId")
        aCoder.encode(self.sitId, forKey: "sitId")
        aCoder.encode(self.eatId, forKey: "eatId")
        aCoder.encode(self.urinationId, forKey: "urinationId")
        aCoder.encode(self.bowelMovmentId, forKey: "bowelMovmentId")
        aCoder.encode(self.labNSFCheck, forKey: "labNSFCheck")
        aCoder.encode(self.hb, forKey: "hb")
        aCoder.encode(self.hct, forKey: "hct")
        aCoder.encode(self.wbc, forKey: "wbc")
        aCoder.encode(self.plt, forKey: "plt")
        aCoder.encode(self.pmn, forKey: "pmn")
        aCoder.encode(self.lym, forKey: "lym")
        aCoder.encode(self.eo, forKey: "eo")
        aCoder.encode(self.pt, forKey: "pt")
        aCoder.encode(self.ptt, forKey: "ptt")
        aCoder.encode(self.inr, forKey: "inr")
        aCoder.encode(self.na, forKey: "na")
        aCoder.encode(self.k, forKey: "k")
        aCoder.encode(self.cl, forKey: "cl")
        aCoder.encode(self.co2, forKey: "co2")
        aCoder.encode(self.bun, forKey: "bun")
        aCoder.encode(self.cr, forKey: "cr")
        aCoder.encode(self.bs, forKey: "bs")
        aCoder.encode(self.cxr, forKey: "cxr")
        aCoder.encode(self.ctBrain, forKey: "ctBrain")
        aCoder.encode(self.pneumothorax, forKey: "pneumothorax")
        aCoder.encode(self.pneumocephalus, forKey: "pneumocephalus")
        aCoder.encode(self.labOther, forKey: "labOther")
        aCoder.encode(self.physicalOther, forKey: "physicalOther")
        aCoder.encode(self.currentTreatment, forKey: "currentTreatment")
        aCoder.encode(self.escotComment, forKey: "escotComment")
        aCoder.encode(self.cspine, forKey: "cspine")
        aCoder.encode(self.gaReccords, forKey: "gaReccords")
        aCoder.encode(self.airwayReccords, forKey: "airwayReccords")
        aCoder.encode(self.deformReccords, forKey: "deformReccords")
        aCoder.encode(self.drainsReccords, forKey: "drainsReccords")
        aCoder.encode(self.respReccords, forKey: "respReccords")
        aCoder.encode(self.createBy, forKey: "createBy")
        aCoder.encode(self.macId, forKey: "macId")
    }
}
