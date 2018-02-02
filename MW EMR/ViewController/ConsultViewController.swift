//
//  ConsultViewController.swift
//  MW EMR
//
//  Created by Patarapon Tokham on 6/14/2559 BE.
//  Copyright © 2559 AunzNuBee. All rights reserved.
//

import UIKit
import Material
class ConsultViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var physicalStatusView: UIView!
    @IBOutlet weak var labAssessmentView: UIView!
    @IBOutlet weak var aviationView: UIView!
    
    //GA
    @IBOutlet var gaGroupButton: [UIButton]!
    @IBOutlet weak var gaDrugLabel: UILabel!
    @IBOutlet weak var gaLastDiseAtLabel: UILabel!
    @IBOutlet weak var gaTimeLabel: UILabel!
    
    //Airway
    @IBOutlet var airwayGroupButton: [UIButton]!
    @IBOutlet var airwayTrachGroupButton: [UIButton]!
    @IBOutlet weak var airwayNoLabel: UILabel!
    @IBOutlet weak var airwayFixLabel: UILabel!
    @IBOutlet weak var cSpineLabel: UILabel!
    
    //RESp
    @IBOutlet var respGroupButton: [UIButton]!
    @IBOutlet var resp2ButtonGroup: [UIButton]!
    @IBOutlet weak var respWheezingLabel: UILabel!
    @IBOutlet weak var respO2CannulaLabel: UILabel!
    @IBOutlet weak var respO2MaskLabel: UILabel!
    @IBOutlet weak var respCollarMaskLabel: UILabel!
    @IBOutlet weak var respRateMinTextField: TextField!
    @IBOutlet weak var respVtTextField: TextField!
    @IBOutlet weak var respFiO2TextField: TextField!
    @IBOutlet weak var respITextField: TextField!
    @IBOutlet weak var respETextField: TextField!
    @IBOutlet weak var respPeakFlowTextField: TextField!
    @IBOutlet weak var respPEEPTextField: TextField!
    @IBOutlet weak var respPSTextField: TextField!
    
    //DP
    @IBOutlet var dpGroupButton: [UIButton]!
    
    //drain
    @IBOutlet var drainGroupButton: [UIButton]!
    @IBOutlet weak var drainOtherLabel: UILabel!
    
    //cvs
    @IBOutlet weak var cvsLabel: UILabel!
    
    //nero
    @IBOutlet weak var neroNSFButton: UIButton!
    @IBOutlet weak var neroELabel: UILabel!
    @IBOutlet weak var neroMLabel: UILabel!
    @IBOutlet weak var neroVLabel: UILabel!
    
    //TempC
    @IBOutlet var tempCGroupButton: [UIButton]!
    @IBOutlet weak var tempCLabel: UILabel!
    
    //prmin
    @IBOutlet var prminGroupButton: [UIButton]!
    @IBOutlet weak var prminLabel: UILabel!
    
    //MotoPower
    @IBOutlet weak var mpTLLabel: UILabel!
    @IBOutlet weak var mpTRLabel: UILabel!
    @IBOutlet weak var mpBLLabel: UILabel!
    @IBOutlet weak var mpBRLabel: UILabel!
    
    //pupil
    @IBOutlet weak var pupilRtMMLabel: UILabel!
    @IBOutlet var pupilRtGroupButton: [UIButton]!
    @IBOutlet weak var pupilLtMMLabel: UILabel!
    @IBOutlet var pupilLtGroupButton: [UIButton]!
    
    //bpmmhg
    @IBOutlet var bpmmHgGroupButton: [UIButton]!
    @IBOutlet weak var bpmmHgILabel: UILabel!
    @IBOutlet weak var bpmmHgRLabel: UILabel!
    
    @IBOutlet weak var o2SatLabel: UILabel!
    
    @IBOutlet weak var painScoreLabel: UILabel!
    @IBOutlet var dispalPulseGroupButton: [UIButton]!
    @IBOutlet weak var dispalPulseOtherLabel: UILabel!
    
    @IBOutlet weak var faWalkLabel: UILabel!
    @IBOutlet weak var faSitLabel: UILabel!
    @IBOutlet weak var faEatLabel: UILabel!
    @IBOutlet weak var faUrinationLabel: UILabel!
    @IBOutlet weak var faBowelLabel: UILabel!
    
    //Lab
    //MARK:- LabAssessment
    @IBOutlet weak var LAHBTextField: TextField!
    @IBOutlet weak var LAHCTTextField: TextField!
    @IBOutlet weak var LAWBCTextField: TextField!
    @IBOutlet weak var LAPLTTextField: TextField!
    @IBOutlet weak var LAPMNTextField: TextField!
    @IBOutlet weak var LALYMTextField: TextField!
    @IBOutlet weak var LAEOTextField: TextField!
    @IBOutlet weak var LAPTTextField: TextField!
    @IBOutlet weak var LAPTTTextField: TextField!
    @IBOutlet weak var LAINRTextField: TextField!
    @IBOutlet weak var LANATextField: TextField!
    @IBOutlet weak var LAKTextField: TextField!
    @IBOutlet weak var LACLTextField: TextField!
    @IBOutlet weak var LACO2TextField: TextField!
    @IBOutlet weak var LABUNTextField: TextField!
    @IBOutlet weak var LACRTextField: TextField!
    @IBOutlet weak var LABSTextField: TextField!
    @IBOutlet weak var LACXRTextField: TextField!
    @IBOutlet weak var LACTBrainTextField: TextField!
    @IBOutlet weak var LAOtherTextField: TextField!
    @IBOutlet var LAPneumothraxGroupButton: [UIButton]!
    @IBOutlet var LAPneumocephalusGroupButton: [UIButton]!
    @IBOutlet weak var nsfButton: UIButton!

    
    //aviation
    @IBOutlet weak var triageLevelTextField: TextField!
    @IBOutlet weak var progosisTextField: TextField!
    @IBOutlet weak var contagiousTextField: TextField!
    @IBOutlet weak var resultTextField: TextField!
    @IBOutlet weak var modeTextField: TextField!
    @IBOutlet weak var commentTextField: TextField!
    @IBOutlet weak var wheelChairTextField: TextField!
    @IBOutlet weak var stretcherTextField: TextField!
    @IBOutlet weak var seatTextField: TextField!
    @IBOutlet weak var oxygenTextField: TextField!
    @IBOutlet weak var otherTextField: TextView!
    
    
    
    
    var consultResult : ConsultResult?

    override func viewDidLoad() {
        super.viewDidLoad()
        physicalStatusView.layer.cornerRadius = 5
        physicalStatusView.layer.shadowColor = UIColor.black.cgColor
        physicalStatusView.layer.shadowOffset = CGSize(width:1.0, height:1.0)
        physicalStatusView.layer.shadowOpacity = 0.5
        physicalStatusView.layer.shadowRadius = 1.5
        
        labAssessmentView.layer.cornerRadius = physicalStatusView.layer.cornerRadius
        labAssessmentView.layer.shadowColor = physicalStatusView.layer.shadowColor
        labAssessmentView.layer.shadowOffset = physicalStatusView.layer.shadowOffset
        labAssessmentView.layer.shadowOpacity = physicalStatusView.layer.shadowOpacity
        labAssessmentView.layer.shadowRadius = physicalStatusView.layer.shadowRadius
        
        aviationView.layer.cornerRadius = physicalStatusView.layer.cornerRadius
        aviationView.layer.shadowColor = physicalStatusView.layer.shadowColor
        aviationView.layer.shadowOffset = physicalStatusView.layer.shadowOffset
        aviationView.layer.shadowOpacity = physicalStatusView.layer.shadowOpacity
        aviationView.layer.shadowRadius = physicalStatusView.layer.shadowRadius

        
        if consultResult != nil {
            self.scrollView.isHidden = false
            //GA
            for item in (consultResult?.ga)! {
                if item.value == 178  {
                    gaGroupButton[0].setImage(UIImage(named: "checked"), for: UIControlState.normal)
                    gaGroupButton[0].isEnabled = true
                }else{
                    for button in gaGroupButton {
                        if button.tag ==  item.value {
                            button.setImage(UIImage(named: "checked"), for: UIControlState.normal)
                            button.isEnabled = true
                        }
                        
                        if item.value == 186{
                            self.gaDrugLabel.text = "Drug : " + (consultResult?.sedatedDrung ?? "-")
                            self.gaLastDiseAtLabel.text = "Last dose at  : " + (consultResult?.lastDose ?? "-")
                        }else if item.value == 187 {
                            self.gaTimeLabel.text = "Time : " + (consultResult?.restraintTime ?? "-")
                        }
                    }
                }
            }
            
            //Airway
            for item in (consultResult?.airway)! {
                if item.value == 168  {
                    airwayGroupButton[0].setImage(UIImage(named: "checked"), for: UIControlState.normal)
                    airwayGroupButton[0].isEnabled = true
                }else{
                    for button in airwayGroupButton {
                        if button.tag ==  item.value {
                            button.setImage(UIImage(named: "checked"), for: UIControlState.normal)
                            button.isEnabled = true
                        }
                    }
                    if item.value == 177  {
                        self.airwayFixLabel.text = "Fix : " + (consultResult?.tubeFix ?? "-") + " cm"
                        self.airwayNoLabel.text = "No " + (consultResult?.tubeNo ?? "")
                        
                        if consultResult?.tubeCuffCheckValue == 166 {
                            self.airwayTrachGroupButton[0].setImage(UIImage(named: "checkmark"), for: UIControlState.normal)
                            self.airwayTrachGroupButton[0].isEnabled = true
                        }else if consultResult?.tubeCuffCheckValue == 167 {
                            self.airwayTrachGroupButton[1].setImage(UIImage(named: "checkmark"), for: UIControlState.normal)
                            self.airwayTrachGroupButton[1].isEnabled = true
                        }
                    }
                }
            }
            
            self.cSpineLabel.text = "NEXUS Criteria for C-Spine : " + (consultResult?.cspine ?? "-")
            
            //RESP
            for item in (consultResult?.resp)! {
                
                if item.value == 159  {
                    respGroupButton[0].setImage(UIImage(named: "checked"), for: UIControlState.normal)
                    respGroupButton[0].isEnabled = false
                }else{
                    for button in respGroupButton {
                        if button.tag ==  item.value {
                            button.setImage(UIImage(named: "checked"), for: UIControlState.normal)
                            button.isEnabled = true
                        }
                        
                    }
                    
                    if item.value == 165 {
                        self.respWheezingLabel.text = (item.RESP_LPM) 
                    }else if item.value == 162 {
                        self.respO2CannulaLabel.text = (item.RESP_LPM) 
                    }else if item.value == 163 {
                        self.respO2MaskLabel.text = (item.RESP_LPM)
                    }else if item.value == 164 {
                        self.respCollarMaskLabel.text = (item.RESP_LPM) 
                    }else if item.value == 198 {
                        for button in resp2ButtonGroup {
                            if consultResult?.ventialValue == button.tag {
                                button.setImage(UIImage(named: "checkmark"), for: UIControlState.normal)
                                button.isEnabled = true
                            }
                        }
                        self.respRateMinTextField.text = consultResult?.ventialRate ?? ""
                        self.respETextField.text = consultResult?.ventialE ?? ""
                        self.respITextField.text = consultResult?.ventialI ?? ""
                        self.respPSTextField.text = consultResult?.ventialPS ?? ""
                        self.respVtTextField.text = consultResult?.ventialVT ?? ""
                        self.respFiO2TextField.text = consultResult?.ventialFIO2 ?? ""
                        self.respPEEPTextField.text = consultResult?.ventialPEEP ?? ""
                        self.respPeakFlowTextField.text = consultResult?.ventialPeakFlow ?? ""
                    }
                }
            }
            
            //cvs
            self.cvsLabel.text = consultResult?.csvDisplay
            
            //Nero
            if consultResult?.neroNSFCheck == "True" {
                self.neroNSFButton.setImage(UIImage(named: "checked"), for: UIControlState.normal)
                self.neroNSFButton.isEnabled = true
            }else{
                self.neroMLabel.text = consultResult?.neroMDisplay
                self.neroELabel.text = consultResult?.neroEDisplay
                self.neroVLabel.text = consultResult?.neroVDisplay
            }
            
            //moto power
            self.mpTLLabel.text = consultResult?.motorPowerTL
            self.mpTRLabel.text = consultResult?.motorPowerTR
            self.mpBLLabel.text = consultResult?.motorPowerBL
            self.mpBRLabel.text = consultResult?.motorPowerBR
            
            //pupil
            self.pupilLtMMLabel.text = consultResult?.pupilLTMin
            self.pupilRtMMLabel.text = consultResult?.pupilRTMin
            
            if consultResult?.pupilRTTypeValue == 32 {
                self.pupilRtGroupButton[0].setImage(UIImage(named: "checkmark"), for: UIControlState.normal)
                self.pupilRtGroupButton[0].isEnabled = true
            }else{
                self.pupilRtGroupButton[1].setImage(UIImage(named: "checkmark"), for: UIControlState.normal)
                self.pupilRtGroupButton[1].isEnabled = true
            }
            
            if consultResult?.pupilLTTypeValue == 32 {
                self.pupilLtGroupButton[0].setImage(UIImage(named: "checkmark"), for: UIControlState.normal)
                self.pupilLtGroupButton[0].isEnabled = true
            }else{
                self.pupilLtGroupButton[1].setImage(UIImage(named: "checkmark"), for: UIControlState.normal)
                self.pupilLtGroupButton[1].isEnabled = true
            }
            
            //TempC
            for button in tempCGroupButton {
                if button.tag ==  Int(consultResult?.tempCheck ?? "0") {
                    button.setImage(UIImage(named: "checkmark"), for: UIControlState.normal)
                    button.isEnabled = true
                }
            }
            
            
            for item in (consultResult?.tempType)! {
                self.tempCLabel.text = (consultResult?.tempValue)! + " " + (item.display)
            }
            
            //PR/Min
            for button in prminGroupButton {
                if button.tag ==  Int(consultResult?.prMin ?? "0") {
                    button.setImage(UIImage(named: "checkmark"), for: UIControlState.normal)
                    button.isEnabled = true
                }
            }
            
            self.prminLabel.text = consultResult?.prMinVal
            
            //BPmmHG
            for button in bpmmHgGroupButton {
                if button.tag ==  Int(consultResult?.bmMinHg ?? "0") {
                    button.setImage(UIImage(named: "checkmark"), for: UIControlState.normal)
                    button.isEnabled = true
                }
            }
            
            self.bpmmHgILabel.text = consultResult?.bmVal1
            self.bpmmHgRLabel.text = consultResult?.bmVal2
            
            //Deformity & Protection
            for item in (consultResult?.deform)! {
                if item.value == 143  {
                    dpGroupButton[0].setImage(UIImage(named: "checked"), for: UIControlState.normal)
                    dpGroupButton[0].isEnabled = true
                }else{
                    for button in dpGroupButton {
                        if button.tag ==  item.value {
                            button.setImage(UIImage(named: "checked"), for: UIControlState.normal)
                            button.isEnabled = true
                        }
                    }
                }
                
            }
            
            //O2Sat
            self.o2SatLabel.text = consultResult?.o2Sat
            
            //pain score
            self.painScoreLabel.text = consultResult?.painScore
            
            //functional assessment
            self.faWalkLabel.text = consultResult?.walkDisplay
            self.faSitLabel.text = consultResult?.sitDisplay
            self.faEatLabel.text = consultResult?.eatDisplay
            self.faUrinationLabel.text = consultResult?.urinationDisplay
            self.faBowelLabel.text = consultResult?.bowelMovmentDisplay
            
            //Drain
            for item in (consultResult?.drains)! {
                if item.value == 133  {
                    drainGroupButton[0].setImage(UIImage(named: "checked"), for: UIControlState.normal)
                    drainGroupButton[0].isEnabled = true
                }else{
                    for button in drainGroupButton {
                        if button.tag ==  item.value {
                            button.setImage(UIImage(named: "checked"), for: UIControlState.normal)
                            button.isEnabled = true
                        }
                    }
                    
                    if item.value == 142 {
                        self.drainOtherLabel.text = ": " + (consultResult?.drainOther ?? "-")
                    }
                }
                
            }
            
            //dispal
            for button in dispalPulseGroupButton {
                if button.tag ==  consultResult?.distalPulseValue {
                    button.setImage(UIImage(named: "checkmark"), for: UIControlState.normal)
                    button.isEnabled = true
                }
                
                
            }
            
            if consultResult?.distalPulseValue == 199 {
                self.dispalPulseOtherLabel.text = consultResult?.distalOther
            }
            
            //Lab Assessment
            if consultResult?.labNSFCheck == "True" {
                self.labAssessmentView.isUserInteractionEnabled = false
            }else{
                self.LAHBTextField.text = consultResult?.hb
                self.LAHCTTextField.text = consultResult?.hct
                self.LAWBCTextField.text = consultResult?.wbc
                self.LAPLTTextField.text = consultResult?.plt
                self.LAPMNTextField.text = consultResult?.pmn
                self.LALYMTextField.text = consultResult?.lym
                self.LAEOTextField.text = consultResult?.eo
                self.LAPTTextField.text = consultResult?.pt
                self.LAPTTTextField.text = consultResult?.ptt
                self.LAINRTextField.text = consultResult?.inr
                self.LANATextField.text = consultResult?.na
                self.LAKTextField.text = consultResult?.k
                self.LACLTextField.text = consultResult?.cl
                self.LACO2TextField.text = consultResult?.co2
                self.LABUNTextField.text = consultResult?.bun
                self.LACRTextField.text = consultResult?.cr
                self.LABSTextField.text = consultResult?.bs
                self.LACXRTextField.text = consultResult?.cxr
                self.LACTBrainTextField.text = consultResult?.ctBrain
                self.LAOtherTextField.text = consultResult?.labOther
                if consultResult?.pneumocepha == "True" {
                    self.LAPneumocephalusGroupButton[0].setImage(UIImage(named: "checkmark"), for: UIControlState.normal)
                }else{
                    self.LAPneumocephalusGroupButton[1].setImage(UIImage(named: "checkmark"), for: UIControlState.normal)
                }
                
                if consultResult?.pneumotholax == "True" {
                    self.LAPneumothraxGroupButton[0].setImage(UIImage(named: "checkmark"), for: UIControlState.normal)
                }else{
                    self.LAPneumothraxGroupButton[1].setImage(UIImage(named: "checkmark"), for: UIControlState.normal)
                }
            }
            
            //aviation
            self.triageLevelTextField.text = consultResult?.triageLevelDisplay
            progosisTextField.text = consultResult?.prognosisForFlight
            contagiousTextField.text = consultResult?.contagiusCondition
            resultTextField.text = consultResult?.result
            modeTextField.text = consultResult?.flightMode
            commentTextField.text = consultResult?.recommend
            wheelChairTextField.text = consultResult?.wheelChair
            stretcherTextField.text = consultResult?.stretcher
            seatTextField.text = consultResult?.seatTypeDisplay
            oxygenTextField.text = consultResult?.oxygen
            otherTextField.text = "Other : "
            if let otherReq = consultResult?.otherReq {
                for (index,other) in otherReq.enumerated() {
                    if index == 0 {
                        otherTextField.text = otherTextField.text + ((other.display) )
                    }else{
                        otherTextField.text = otherTextField.text + ", " + ((other.display) )
                    }
                    
                }
            }
            

        }else{
            self.scrollView.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
