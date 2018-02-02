import ObjectMapper

class ConsultResult: Mappable {
    var id = ""
    var bmMinHg = ""
    var bmVal1 = ""
    var bmVal2 = ""
    var bs = ""
    var bun = ""
    var cl = ""
    var co2 = ""
    var contagiusCondition = ""
    var contagiusOther = ""
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
    var labNSFCheck = ""
    var labOther = ""
    var lastDose = ""
    var lym = ""
    var motorPowerBL = ""
    var motorPowerBR = ""
    var motorPowerTL = ""
    var motorPowerTR = ""
    var na = ""
    var neroNSFCheck = ""
    var o2Sat = ""
    var oxzygen = ""
    var painScore = ""
    var plt = ""
    var pmn = ""
    var pneumocepha = ""
    var pneumotholax = ""
    var prMin = ""
    var prMinVal = ""
    var pt = ""
    var ptt = ""
    var pupilLTMin = ""
    var pupilRTMin = ""
    var recommend = ""
    var restraintTime = ""
    var sedatedDrung = ""
    var stretcher = ""
    var tempCheck = ""
    var tempValue = ""
    var tubeFix = ""
    var tubeNo = ""
    var ventialE = ""
    var ventialFIO2 = ""
    var ventialI = ""
    var ventialPEEP = ""
    var ventialPS = ""
    var ventialRate = ""
    var ventialVT = ""
    var ventialPeakFlow = ""
    var wbc = ""
    var wheelchairRequire = ""
    var neroE = ""
    var bowelMovmentValue = 0
    var bowelMovmentDisplay = ""
    var tubeCuffCheckValue = 0
    var tubeCuffCehckDisplay = ""
    var ventialValue = 0
    var ventialDisplay = ""
    var csvValue = 0
    var csvDisplay = ""
    var neroEValue = 0
    var neroEDisplay = ""
    var neroMValue = 0
    var neroMDisplay = ""
    var neroVValue = 0
    var neroVDisplay = ""
    var pupilRTTypeValue = 0
    var pupilRTTypeDisplay = ""
    var pupilLTTypeValue = 0
    var pupilLTTypeDisplay = ""
    var distalPulseValue = 0
    var distalPulseDisplay = ""
    var walkValue = 0
    var walkDisplay = ""
    var sitValue = 0
    var sitDisplay = ""
    var eatValue = 0
    var eatDisplay = ""
    var urinationValue = 0
    var urinationDisplay = ""
    var triageLevelValue = 0
    var triageLevelDisplay = ""
    var prognosisFlightValue = 0
    var prognosisFlightDisplay = ""
    var consultResultValue = 0
    var consultResultDisplay = ""
    var flightModeValue = 0
    var flightModeDisplay = ""
    var wheelchairTypeValue = 0
    var wheelchairTypeDisplay = ""
    var seatTypeValue = 0
    var seatTypeDisplay = ""
    var oxygenAmountValue = 0
    var oxygenAmountDisplay = ""
    var oxygenTypeValue = 0
    var oxygenTypeDisplay = ""
    var oxygen = ""
    var ga = [DetailItem]()
    var airway = [DetailItem]()
    var resp = [DetailItem]()
    var deform = [DetailItem]()
    var drains = [DetailItem]()
    var otherReq = [DetailItem]()
    var tempType = [DetailItem]()
    var cspine = ""
    var result = ""
    var flightMode = ""
    var hospital = ""
    var visitDate = ""
    var dx = ""
    var symptomDate = ""
    var prognosisForFlight = ""
    var wheelChair = ""
    var consultStretcher = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable 91
    func mapping(map: Map) {
        id <- map["CONSULT_ID"]
        hospital <- map["hospital"]
        visitDate <- map["visitDate"]
        dx <- map["Dx"]
        symptomDate <- map["symptomDate"]
        bs <- map["CONSULT_BS"]
        bmMinHg <- map["CONSULT_BM_MIN_HG"]
        bmVal1 <- map["CONSULT_BM_VAL1"]
        bmVal2 <- map["CONSULT_BM_VAL2"]
        bs <- map["CONSULT_BS"]
        bun <- map["CONSULT_BUN"]
        cl <- map["CONSULT_CL"]
        co2 <- map["CONSULT_CO2"]
        contagiusCondition <- map["CONTAGIUS_CONDITION"]
        contagiusOther <- map["CONSULT_CONTAGIUS_OTHER"]
        cr <- map["CONSULT_CR"]
        ctBrain <- map["CONSULT_CT_BRAIN"]
        cxr <- map["CONSULT_CXR"]
        distalOther <- map["CONSULT_DISTAL_OTHER"]
        drainOther <- map["CONSULT_DRAIN_OTHER"]
        eo <- map["CONSULT_EO"]
        hb <- map["CONSULT_HB"]
        hct <- map["CONSULT_HCT"]
        inr <- map["CONSULT_INR"]
        k <- map["CONSULT_K"]
        labNSFCheck <- map["CONSULT_LAB_NSF_CHECK"]
        labOther <- map["CONSULT_LAB_OTHER"]
        lastDose <- map["CONSULT_LAST_DOSE"]
        lym <- map["CONSULT_LYM"]
        motorPowerBL <- map["CONSULT_MOTOR_POWER_BL"]
        motorPowerBR <- map["CONSULT_MOTOR_POWER_BR"]
        motorPowerTL <- map["CONSULT_MOTOR_POWER_TL"]
        motorPowerTR <- map["CONSULT_MOTOR_POWER_TR"]
        na <- map["CONSULT_NA"]
        neroNSFCheck <- map["CONSULT_NERO_NSF_CHECK"]
        o2Sat <- map["CONSULT_O2_SAT"]
        oxzygen <- map["CONSULT_OXZYGEN"]
        painScore <- map["CONSULT_PAIN_SCORE"]
        plt <- map["CONSULT_PLT"]
        pmn <- map["CONSULT_PMN"]
        pneumocepha <- map["CONSULT_PNEUMOCEPHA"]
        pneumotholax <- map["CONSULT_PNEUMOTHOLAX"]
        prMin <- map["CONSULT_PR_MIN"]
        prMinVal <- map["CONSULT_PR_MIN_VAL"]
        pt <- map["CONSULT_PT"]
        ptt <- map["CONSULT_PTT"]
        pupilLTMin <- map["CONSULT_PUPIL_LT_MIN"]
        pupilRTMin <- map["CONSULT_PUPIL_RT_MIN"]
        recommend <- map["CONSULT_RECCOMMEND"]
        restraintTime <- map["CONSULT_RESTRAINT_TIME"]
        sedatedDrung <- map["CONSULT_SEDATED_DRUNG"]
        consultStretcher <- map["CONSULT_STRETCHER"]
        stretcher <- map["STRETCHER"]
        tempCheck <- map["CONSULT_TEMP_CHECK"]
        tempValue <- map["CONSULT_TEMP_VALUE"]
        tubeFix <- map["CONSULT_TUBE_FIX"]
        tubeNo <- map["CONSULT_TUBE_NO"]
        ventialE <- map["CONSULT_VENTIAL_E"]
        ventialFIO2 <- map["CONSULT_VENTIAL_FIO2"]
        ventialI <- map["CONSULT_VENTIAL_I"]
        ventialPEEP <- map["CONSULT_VENTIAL_PEEP"]
        ventialPS <- map["CONSULT_VENTIAL_PS"]
        ventialRate <- map["CONSULT_VENTIAL_RATE"]
        ventialVT <- map["CONSULT_VENTIAL_VT"]
        ventialPeakFlow <- map["CONSULT_VENYIAL_PEAK_FLOW"]
        wbc <- map["CONSULT_WBC"]
        wheelchairRequire <- map["CONSULT_WHEELCHAIR_REQUIRE"]
        neroE <- map["MasterData_NERO_E"]
        bowelMovmentValue <- map["BOWEL_MOVMENT.value"]
        bowelMovmentDisplay <- map["BOWEL_MOVMENT.display"]
        tubeCuffCheckValue <- map["TUBE_CUFF_CHECK.value"]
        tubeCuffCehckDisplay <- map["TUBE_CUFF_CHECK.display"]
        ventialValue <- map["VENTIAL.value"]
        ventialDisplay <- map["VENTIAL.display"]
        csvValue <- map["CSV.value"]
        csvDisplay <- map["CSV.display"]
        neroEValue <- map["NERO_E.value"]
        neroEDisplay <- map["NERO_E.display"]
        neroMValue <- map["NERO_M.value"]
        neroMDisplay <- map["NERO_M.display"]
        neroVValue <- map["NERO_V.value"]
        neroVDisplay <- map["NERO_V.display"]
        pupilRTTypeValue <- map["PUPIL_RT_TYPE.value"]
        pupilRTTypeDisplay <- map["PUPIL_RT_TYPE.display"]
        pupilLTTypeValue <- map["PUPIL_LT_TYPE.value"]
        pupilLTTypeDisplay <- map["PUPIL_LT_TYPE.display"]
        distalPulseValue <- map["DISTAL_PULSE.value"]
        distalPulseDisplay <- map["DISTAL_PULSE.display"]
        walkValue <- map["WALK.value"]
        walkDisplay <- map["WALK.display"]
        sitValue <- map["SIT.value"]
        sitDisplay <- map["SIT.display"]
        eatValue <- map["EAT.value"]
        eatDisplay <- map["EAT.display"]
        urinationValue <- map["URINATION.value"]
        urinationDisplay <- map["URINATION.display"]
        triageLevelValue <- map["TRIAGE_LEVEL.value"]
        triageLevelDisplay <- map["TRIAGE_LEVEL.display"]
        prognosisFlightValue <- map["PROGNOSIS_FLIGHT.value"]
        prognosisFlightDisplay <- map["PROGNOSIS_FLIGHT.display"]
        consultResultValue <- map["COSULT_RESULT.value"]
        consultResultDisplay <- map["COSULT_RESULT.display"]
        flightModeValue <- map["FLIGHT_MODE.value"]
        flightModeDisplay <- map["FLIGHT_MODE.display"]
        wheelchairTypeValue <- map["WHEELCHAIR_TYPE.value"]
        wheelchairTypeDisplay <- map["WHEELCHAIR_TYPE.display"]
        seatTypeValue <- map["SEAT_TYPE.value"]
        seatTypeDisplay <- map["SEAT_TYPE.display"]
        oxygenAmountValue <- map["OXZYGEN_AMOUNT.value"]
        oxygenAmountDisplay <- map["OXZYGEN_AMOUNT.display"]
        oxygenTypeValue <- map["OXZYGEN_TYPE.value"]
        oxygenTypeDisplay <- map["OXZYGEN_TYPE.display"]
        oxygen <- map["OXYGEN"]
        ga <- map["GA"]
        airway <- map["AIRWAY"]
        resp <- map["RESP"]
        deform <- map["DEFORM"]
        drains <- map["DRAINS"]
        otherReq <- map["ORTHER_REQ"]
        tempType <- map["TEMP_TYPE"]
        cspine <- map["CONSULT_CSPINE"]
        result <- map["RESULT"]
        flightMode <- map["FLIGHT_MODE"]
        prognosisForFlight <- map["PROGNOSIS_FOR_FLIGHT"]
        wheelChair <- map["WHEEL_CHAIR"]
    }
}

class DetailItem: Mappable {
    
    var value = 0
    var display = ""
    var RESP_LPM = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        value <- map["value"]
        display <- map["display"]
        RESP_LPM <- map["RESP_LPM"]
    }
}
