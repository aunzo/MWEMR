import UIKit
import Material
import RxSwift
import ActionSheetPicker_3_0
import MGSwipeTableCell
import ObjectMapper
import RealmSwift
import ALCameraViewController

class PreFlightViewController: UIViewController {
    
    //MARK:- variable
    let bag = DisposeBag()
    let interventionViewModel = InterventionViewModel()
    let flightPersonViewModel = FlightPersonViewModel()
    let summaryViewModel = SummaryReportViewModel()
    let masterDataViewModel = MasterDataViewModel()
    var summaryReportItem:[String:String]?
    var interventionItem:[String:String]?
    var flightPositionItem:[String:String]?
    var profile = Customer()
    
    @IBOutlet weak var summaryReportTableView: UITableView!
    
    //MARK:- CustomerProfile
    @IBOutlet weak var customerIDLabel: UILabel!
    @IBOutlet weak var customerFullnameLabel: UILabel!
    @IBOutlet weak var customerBirthDayLabel: UILabel!
    @IBOutlet weak var customerGenderLabel: UILabel!
    @IBOutlet weak var customerAgeLabel: UILabel!
    

    //MARK:- sectionView
    @IBOutlet weak var clinicalInformationView: UIView!
    @IBOutlet weak var customerView: UIView!
    @IBOutlet weak var physicalStatusView: UIView!
    @IBOutlet weak var labAssessmentView: UIView!
    @IBOutlet weak var otherPhycicalView: UIView!
    @IBOutlet weak var mainScrollview: UIScrollView!
    
    //MARK:- Clinical Information
    @IBOutlet weak var hospitalTextField: TextField!
    @IBOutlet weak var visitDateTextField: TextField!
    @IBOutlet weak var capitalLetterTextField: TextField!
    @IBOutlet weak var briefHistoryTextField: TextField!
    @IBOutlet weak var symptomTextField: TextField!
    @IBOutlet weak var aircraftButton: RaisedButton!
    
    //MARK:- summary report
    @IBOutlet weak var sumaryReportTableView: UITableView!
    @IBOutlet weak var addSummaryReportButton: RaisedButton!
    @IBOutlet weak var heigthSummaryReportConstraint: NSLayoutConstraint!
    
    //MARK:- intervention
    @IBOutlet weak var interventionTableView: UITableView!
    @IBOutlet weak var addInterventionButton: RaisedButton!
    @IBOutlet weak var interventionTextField: TextField!
    @IBOutlet weak var interventionDateTextField: TextField!
    @IBOutlet weak var heigthInterventionConstraint: NSLayoutConstraint!
    
    //MARK:- GA
    @IBOutlet var gaGroupButton: [UIButton]!
    @IBOutlet weak var gaSedatedDrugTextField: TextField!
    @IBOutlet weak var gaSedatedLastDiseAtTextField: TextField!
    @IBOutlet weak var gaRestraintTimeTextField: TextField!
    
    //MARK:- Airway
    @IBOutlet var airwayGroupButton: [UIButton]!
    @IBOutlet var tracheostomyTubeGroupButton: [UIButton]!
    @IBOutlet weak var trachNoTextField: TextField!
    @IBOutlet weak var trachFixTextField: TextField!
    @IBOutlet weak var cSpineTextField: TextField!
    
    //MARK:- RESP
    
    @IBOutlet var respButtonGroup: [UIButton]!
    @IBOutlet var resp2ButtonGroup: [UIButton]!
    @IBOutlet weak var ventialtorView: UIView!
    @IBOutlet weak var respWheezingTextField: TextField!
    @IBOutlet weak var respO2CannulaTextField: TextField!
    @IBOutlet weak var respO2MaskTextField: TextField!
    @IBOutlet weak var respCollarMaskTextField: TextField!
    @IBOutlet weak var respRateMinTextField: TextField!
    @IBOutlet weak var respVtTextField: TextField!
    @IBOutlet weak var respFiO2TextField: TextField!
    @IBOutlet weak var respITextField: TextField!
    @IBOutlet weak var respETextField: TextField!
    @IBOutlet weak var respPeakFlowTextField: TextField!
    @IBOutlet weak var respPEEPTextField: TextField!
    @IBOutlet weak var respPSTextField: TextField!
    
    //MARK:- CVS
    @IBOutlet weak var cvsButton: RaisedButton!
    
    //MARK:- Neuro
    @IBOutlet weak var neuroButton: UIButton!
    @IBOutlet weak var neuroEButton: RaisedButton!
    @IBOutlet weak var neuroMButton: RaisedButton!
    @IBOutlet weak var neuroVButton: RaisedButton!
    
    //MARK:- TempC
    @IBOutlet var tempCGroupButton: [UIButton]!
    @IBOutlet weak var tempCTextField: TextField!
    @IBOutlet weak var tempCSelectButton: RaisedButton!
    
    //MARK:- PR/Min
    @IBOutlet var prminGroupButton: [UIButton]!
    @IBOutlet weak var prminTextField: TextField!
    
    //MARK:- Deformity & Protection
    @IBOutlet var DPGroupButton: [UIButton]!
    
    //MARK:- Drains
    @IBOutlet var drainsGroupButton: [UIButton]!
    @IBOutlet weak var drainsOtherTextField: TextField!
    
    //MARK:- MotorPower
    @IBOutlet var motorPowerButton: [RaisedButton]!
    
    //MARK:- pupilRt
    @IBOutlet weak var pupilRtTextField: TextField!
    @IBOutlet var pupilRtGroupButton: [UIButton]!
    @IBOutlet weak var pupilRtmmTextField: TextField!
    @IBOutlet weak var pupilLtTextField: TextField!
    @IBOutlet var pupilLtGroupButton: [UIButton]!
    @IBOutlet weak var pupilLtmmTextField: TextField!
    
    //MARK:- BPmmHg
    @IBOutlet var BPmmHgGroupButton: [UIButton]!
    @IBOutlet weak var BPmmHgtextField: TextField!
    @IBOutlet weak var BPmmHg2TextField: TextField!
    
    //MARK:- O2Sat
    @IBOutlet weak var O2SatTextField: TextField!
    
    //MARK:- painScore
    @IBOutlet weak var painScoreButton: RaisedButton!
    
    //MARK:- distalPulse
    @IBOutlet var distalPulseGroupButton: [UIButton]!
    @IBOutlet weak var distalPulseOtherTextField: TextField!
    
    //MARK:- Functional Assessment
    @IBOutlet weak var FAWalkButton: RaisedButton!
    @IBOutlet weak var FASitButton: RaisedButton!
    @IBOutlet weak var FAEatButton: RaisedButton!
    @IBOutlet weak var FAUrinationButton: RaisedButton!
    @IBOutlet weak var FABowlMovementButton: RaisedButton!
    
    @IBOutlet var painAssToolButton: [UIButton]!
    @IBOutlet weak var locationTextField: TextField!
    @IBOutlet weak var durationTextField: TextField!
    
    @IBOutlet var charateristicButton: [UIButton]!
    @IBOutlet var frequenceButton: [UIButton]!
    
    @IBOutlet weak var otherTextField: TextField!
    
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
    @IBOutlet weak var bottomScrollViewConstraint: NSLayoutConstraint!
    
    
    //MARK:- Other
    @IBOutlet weak var otherPhycicalPositionButton: RaisedButton!
    @IBOutlet weak var otherPhysicalTableView: UITableView!
    @IBOutlet weak var otherPhysicalNameTextField: TextField!
    @IBOutlet weak var otherPhysicalOtherTextField: TextField!
    @IBOutlet weak var otherPhysicalCurrentTreatmentTextField: TextField!
    @IBOutlet weak var otherPhysicalExcotCommentTextField: TextField!
    @IBOutlet weak var addOtherPhysicalButton: RaisedButton!
    @IBOutlet weak var heigthFlightPersonConstraint: NSLayoutConstraint!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.mainScrollview.canCancelContentTouches = false
        
        self.setupViewSection()
        
        self.profile = CustomerSingleton.sharedInstance.customerProfile
        self.customerIDLabel.text = profile.personalId
        self.customerFullnameLabel.text = profile.fullName
        self.customerBirthDayLabel.text = profile.birthDay
        self.customerGenderLabel.text = profile.gender
        self.customerAgeLabel.text = "\(profile.age)"
        
        //MARK:- intervention
        interventionViewModel.interventionChange.subscribe(onNext: { (action) in
            if action == .list || action == .delete{
                self.interventionTextField.text = ""
                self.interventionDateTextField.text = ""
                
                if self.interventionViewModel.numberOfItems() == 0 {
                    self.heigthInterventionConstraint.constant = 100
                }else{
                    let heigth = (self.interventionViewModel.numberOfItems() + 1) * 50
                    self.heigthInterventionConstraint.constant = CGFloat(heigth)
                }
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.interventionTableView.layoutSubviews()
                })
                
                self.interventionTableView.reloadData()
            }else if action == .addOrUpdate {
                self.summaryViewModel.setSelectIndex(index: 0)
                let alert = UIAlertController(title: (self.addInterventionButton.titleLabel?.text)! + " Success.", message: "", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (alert) in
                    self.addInterventionButton.setTitle("Add", for: UIControlState.normal)
                    self.interventionItem = nil
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }).disposed(by: bag)
        
        self.interventionViewModel.load()
        
        //MARK:- summary report
        summaryViewModel.summaryReportChange.subscribe(onNext: { (action) in
            if action == .list || action == .delete{
                if self.summaryViewModel.numberOfItems() == 0 {
                    self.heigthSummaryReportConstraint.constant = 100
                }else{
                    let heigth = (self.summaryViewModel.numberOfItems() + 1) * 50
                    self.heigthSummaryReportConstraint.constant = CGFloat(heigth)
                }
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.sumaryReportTableView.layoutSubviews()
                })
                
                self.sumaryReportTableView.reloadData()
            }else if action == .addOrUpdate {
                let alert = UIAlertController(title: "Success.", message: "", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (alert) in
//                    self.addInterventionButton.setTitle("Add", for: UIControlState.normal)
                    self.summaryReportItem = nil
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }).disposed(by: bag)
        
        self.summaryViewModel.load()
        
        //MARK:- flight person
        flightPersonViewModel.flightPersonChange.subscribe(onNext: { (action) in
            if action == .list || action == .delete{
                self.otherPhysicalNameTextField.text = ""
                
                if self.flightPersonViewModel.numberOfItems() == 0 {
                    self.heigthFlightPersonConstraint.constant = 100
                }else{
                    let heigth = (self.flightPersonViewModel.numberOfItems() + 1) * 50
                    self.heigthFlightPersonConstraint.constant = CGFloat(heigth)
                }
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.otherPhysicalTableView.layoutSubviews()
                })
                
                self.otherPhysicalTableView.reloadData()
            }else if action == .addOrUpdate {
                let alert = UIAlertController(title: (self.addOtherPhysicalButton.titleLabel?.text)! + " Success.", message: "", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (alert) in
                    self.addOtherPhysicalButton.setTitle("Add", for: UIControlState.normal)
                    self.flightPositionItem = nil
                }))
                self.present(alert, animated: true, completion: nil)
            }
            }).disposed(by: bag)
        
        self.flightPersonViewModel.load()
        self.initDataConsultResult()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "viewImageFile" {
            let controller = segue.destination as! ViewImageViewController
            let indexPath = sender as! NSIndexPath
            controller.urlImage = self.summaryViewModel.getImagePath(index: indexPath.row) as String
            controller.isLocal = self.summaryViewModel.fromLocal(index: indexPath.row)
            controller.titleString = self.summaryViewModel.getTitle(index: indexPath.row)
            controller.idReport = self.summaryViewModel.getIdReport(index: indexPath.row)
            controller.finishEditCallback = {
                self.summaryViewModel.load()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.savePreflightTolocal()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

extension PreFlightViewController
{
    @IBAction func closeView(sender: AnyObject)
    {
        self.savePreflightTolocal()
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupViewSection()
    {
        customerView.layer.cornerRadius = 5
        customerView.layer.shadowColor = UIColor.black.cgColor
        customerView.layer.shadowOffset = CGSize(width:1.0,height:1.0)
        customerView.layer.shadowOpacity = 0.5
        customerView.layer.shadowRadius = 1.5
        
        clinicalInformationView.layer.cornerRadius = customerView.layer.cornerRadius
        clinicalInformationView.layer.shadowColor = customerView.layer.shadowColor
        clinicalInformationView.layer.shadowOffset = customerView.layer.shadowOffset
        clinicalInformationView.layer.shadowOpacity = customerView.layer.shadowOpacity
        clinicalInformationView.layer.shadowRadius = customerView.layer.shadowRadius
        
        physicalStatusView.layer.cornerRadius = customerView.layer.cornerRadius
        physicalStatusView.layer.shadowColor = customerView.layer.shadowColor
        physicalStatusView.layer.shadowOffset = customerView.layer.shadowOffset
        physicalStatusView.layer.shadowOpacity = customerView.layer.shadowOpacity
        physicalStatusView.layer.shadowRadius = customerView.layer.shadowRadius
        
        labAssessmentView.layer.cornerRadius = customerView.layer.cornerRadius
        labAssessmentView.layer.shadowColor = customerView.layer.shadowColor
        labAssessmentView.layer.shadowOffset = customerView.layer.shadowOffset
        labAssessmentView.layer.shadowOpacity = customerView.layer.shadowOpacity
        labAssessmentView.layer.shadowRadius = customerView.layer.shadowRadius
        
        otherPhycicalView.layer.cornerRadius = customerView.layer.cornerRadius
        otherPhycicalView.layer.shadowColor = customerView.layer.shadowColor
        otherPhycicalView.layer.shadowOffset = customerView.layer.shadowOffset
        otherPhycicalView.layer.shadowOpacity = customerView.layer.shadowOpacity
        otherPhycicalView.layer.shadowRadius = customerView.layer.shadowRadius
    }
    
    //MARK:- date textField
    @IBAction func textFieldEditing(sender: TextField) {
        var mode = UIDatePickerMode.date
        let dateFomatter = DateFormatter()
        dateFomatter.locale = Locale(identifier: "en_US")
        
        
        if sender == self.gaRestraintTimeTextField || sender == self.gaSedatedLastDiseAtTextField {
            mode = UIDatePickerMode.time
            dateFomatter.dateFormat = "HH:mm"
        }else{
            dateFomatter.dateFormat = "d / M / yyyy"
        }
        let picker = ActionSheetDatePicker(title: "Select Date", datePickerMode: mode, selectedDate: Date(), doneBlock: { (picker, value, index) in
            
            let value = dateFomatter.string(from: value as! Date)
            
            if sender == self.visitDateTextField {
                self.visitDateTextField.text = value
            }else if sender == self.interventionDateTextField {
                self.interventionDateTextField.text = value
            }else if sender == self.symptomTextField {
                self.symptomTextField.text = value
            }else if sender == self.gaRestraintTimeTextField {
                self.gaRestraintTimeTextField.text = value
            }else if sender == self.gaSedatedLastDiseAtTextField {
                self.gaSedatedLastDiseAtTextField.text = value
            }
            sender.resignFirstResponder()
            }, cancel: nil, origin: sender)
        if sender == self.gaRestraintTimeTextField || sender == self.gaSedatedLastDiseAtTextField {
            picker?.locale = Locale(identifier: "th_TH")
        }else{
            picker?.locale = Locale(identifier: "en_US")
        }

        
        picker?.show()
        sender.inputView = UIView()
    }
    
    //MARK:- select picker
    @IBAction func selectPickerClick(sender: RaisedButton) {
        let value = self.getValueItem(button: sender)
        let picker = ActionSheetStringPicker(title: "Select Value", rows: value, initialSelection: 0, doneBlock: { (picker, row, obj) in
                self.setValueToButton(value: value[row], button: sender)
            }, cancel: { (picker) in
                
            }, origin: sender)
        
        picker?.show()
        
    }
    
    
    func getValueItem(button:RaisedButton) -> [String] {
        var data = [String]()
        
        if button == self.painScoreButton {
            data = ["0","1","2","3","4","5","6","7","8","9","10"]
        }else if button == self.motorPowerButton[0] || button ==  self.motorPowerButton[1] || button ==  self.motorPowerButton[2] || button == self.motorPowerButton[3] {
            data = ["0","1","2","3","4","5"]
        }else{
            data = masterDataViewModel.getDataWith(masterFieldID: button.tag)
        }
        return data
    }
    
    func setValueToButton(value:String, button:RaisedButton) {
        
        if button == self.painScoreButton {
            self.painScoreButton.setTitle(value, for: UIControlState.normal)
        }else if button == self.motorPowerButton[0] || button ==  self.motorPowerButton[1] || button ==  self.motorPowerButton[2] || button == self.motorPowerButton[3] {
            self.motorPowerButton[button.tag].setTitle(value, for: UIControlState.normal)
        }else if button == self.aircraftButton {
            self.aircraftButton.setTitle(value, for: UIControlState.normal)
        }else if button == self.neuroEButton {
            self.neuroEButton.setTitle(value, for: UIControlState.normal)
        }else if button == self.neuroMButton {
            self.neuroMButton.setTitle(value, for: UIControlState.normal)
        }else if button == self.neuroVButton {
            self.neuroVButton.setTitle(value, for: UIControlState.normal)
        }else if button == self.tempCSelectButton {
            self.tempCSelectButton.setTitle(value, for: UIControlState.normal)
        }else if button == self.cvsButton {
            self.cvsButton.setTitle(value, for: UIControlState.normal)
        }else if button == self.FAEatButton {
            self.FAEatButton.setTitle(value, for: UIControlState.normal)
        }else if button == self.FASitButton {
            self.FASitButton.setTitle(value, for: UIControlState.normal)
        }else if button == self.FAWalkButton {
            self.FAWalkButton.setTitle(value, for: UIControlState.normal)
        }else if button == self.FAUrinationButton {
            self.FAUrinationButton.setTitle(value, for: UIControlState.normal)
        }else if button == self.FABowlMovementButton {
            self.FABowlMovementButton.setTitle(value, for: UIControlState.normal)
        }else if button == self.otherPhycicalPositionButton {
            self.otherPhycicalPositionButton.setTitle(value, for: UIControlState.normal)
        }
    }
    
    @IBAction func hideKeyboard(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    @IBAction func addSummaryReport(sender: Any) {
        let cameraViewController = CameraViewController(
            croppingParameters: CroppingParameters(
                isEnabled: false,
                allowResizing: true,
                allowMoving: false,
                minimumSize: .zero),
            allowsLibraryAccess: true,
            allowsSwapCameraOrientation: false,
            allowVolumeButtonCapture: true) { (image, asset) in
                self.dismiss(animated: true, completion: {
                    if image != nil {
                        self.alertReportImageDescription(pickedImage: image!)
                    }
                })
        }
        
        self.present(cameraViewController, animated: true, completion: nil)
    }
    
    //MARK:- intervention method
    @IBAction func addIntervention(sender:UIButton) {
        if self.interventionTextField.text != "" && self.interventionDateTextField.text != "" {
            if interventionItem == nil {
                self.interventionViewModel.addOrUpdate(item: ["intervention":self.interventionTextField.text!,"date":self.interventionDateTextField.text!])
            }else{
                let id = interventionItem!["id"]
                self.interventionViewModel.addOrUpdate(item: ["interventionId":id!,"intervention":self.interventionTextField.text!,"date":self.interventionDateTextField.text!])
            }
            
        }else{
            let alertEdit = UIAlertController(title: "Can't Add Intervention", message: "Please input all data.", preferredStyle: UIAlertControllerStyle.alert)
            alertEdit.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (alert) in
            }))
            
            present(alertEdit, animated: true, completion: nil)
        }
        
    }
    
    func actionInterventionData(action : DataAction,indexPath : IndexPath){
        let item = self.interventionViewModel.listItem(index: indexPath.row)
        if action == .addOrUpdate  {
            self.addInterventionButton.setTitle("Edit", for: UIControlState.normal)
            
            self.interventionTextField.text = item["intervention"]
            self.interventionDateTextField.text = item["date"]
            interventionItem = item
        }else{
            let alert = UIAlertController(title: "Remove", message: "You want to remove this item?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: { (alert) in
                
            }))
            
            alert.addAction(UIAlertAction(title: "Remove", style: UIAlertActionStyle.destructive, handler: { (alert) in
                self.interventionViewModel.remove(id: item["id"]!)
                
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func actionSummaryReport(action : DataAction,indexPath : IndexPath){
        
        if action == .list  {
            if self.summaryViewModel.getTypeOfFile(index: indexPath.row) == .pdf {
                let doc = self.summaryViewModel.openPdfFile(index: indexPath.row)
                let readerView = ReaderViewController(readerDocument: doc)
                readerView?.delegate = self
                
                readerView?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                readerView?.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                
                present(readerView!, animated: true, completion: { () -> Void in
                    
                })
            }else{
                self.performSegue(withIdentifier: "viewImageFile", sender: indexPath)
            }
        }else if action == .addOrUpdate  {
            self.summaryViewModel.setSelectIndex(index: indexPath.row)
            self.addSummaryReport(sender: indexPath)
        }else{
            let alert = UIAlertController(title: "Remove", message: "You want to remove this item?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: { (alert) in
                
            }))
            
            alert.addAction(UIAlertAction(title: "Remove", style: UIAlertActionStyle.destructive, handler: { (alert) in
                let item = self.summaryViewModel.listItem(index: indexPath.row)
                self.summaryViewModel.remove(id: item["id"]!)
                
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openSummaryReport(button : UIButton){
        
    }
    
    //MARK:- GA
    @IBAction func gaClick(sender: AnyObject) {
        
        guard let button = gaGroupButton.first(where: { $0.tag == sender.tag }) else
        {
            return
        }
        
        if button.isChecked {
            button.setImage(#imageLiteral(resourceName: "unchecked"), for: UIControlState.normal)
            button.isChecked = false
            if sender.tag == 178 {
                gaGroupButton
                    .filter { $0.tag != 178 }
                    .forEach { $0.isEnabled = true }
                self.gaSedatedLastDiseAtTextField.isEnabled = true
                self.gaSedatedDrugTextField.isEnabled = true
                self.gaRestraintTimeTextField.isEnabled = true
            }else if sender.tag == 186 {
                self.gaSedatedLastDiseAtTextField.isEnabled = false
                self.gaSedatedDrugTextField.isEnabled = false
                self.gaSedatedLastDiseAtTextField.text = ""
                self.gaSedatedDrugTextField.text = ""
            }else if sender.tag == 187 {
                self.gaRestraintTimeTextField.isEnabled = false
                self.gaRestraintTimeTextField.text = ""
            }

        }else{
            button.setImage(#imageLiteral(resourceName: "checked"), for: UIControlState.normal)
            button.isChecked = true
            if sender.tag == 178
            {
                self.gaSedatedLastDiseAtTextField.isEnabled = false
                self.gaSedatedDrugTextField.isEnabled = false
                self.gaRestraintTimeTextField.isEnabled = false
                self.gaSedatedLastDiseAtTextField.text = ""
                self.gaSedatedDrugTextField.text = ""
                self.gaRestraintTimeTextField.text = ""
                gaGroupButton
                    .filter { $0.tag != 178 }
                    .forEach {
                        $0.isChecked = false
                        $0.setImage(#imageLiteral(resourceName: "unchecked"), for: UIControlState.normal)
                        $0.isEnabled = false }
            }
            else if sender.tag == 186
            {
                self.gaSedatedLastDiseAtTextField.isEnabled = true
                self.gaSedatedDrugTextField.isEnabled = true
            }
            else if sender.tag == 187
            {
                self.gaRestraintTimeTextField.isEnabled = true
            }
        }
    }
    
    //MARK:- Airway
    @IBAction func airwayClick(sender: AnyObject) {
        guard let button = airwayGroupButton.first(where: { $0.tag == sender.tag }) else
        {
            return
        }
        
        if button.isChecked {
            button.setImage(#imageLiteral(resourceName: "unchecked"), for: UIControlState.normal)
            button.isChecked = false
            if sender.tag == 168 {
                self.cSpineTextField.isEnabled = true
                airwayGroupButton
                    .filter { $0.tag != 168 }
                    .forEach { $0.isEnabled = true }
            }else if sender.tag == 177 {
                self.trachFixTextField.isEnabled = false
                self.trachNoTextField.isEnabled = false
                self.trachFixTextField.text = ""
                self.trachNoTextField.text = ""
                tracheostomyTubeGroupButton
                    .forEach {
                        $0.isChecked = false
                        $0.setImage(UIImage(named: "nonfilled"), for: UIControlState.normal)
                        $0.isEnabled = false }
            }
        }else{
            button.setImage(#imageLiteral(resourceName: "checked"), for: UIControlState.normal)
            button.isChecked = true
            if sender.tag == 168 {
                airwayGroupButton
                    .filter { $0.tag != 168 }
                    .forEach {
                        $0.setImage(UIImage(named: "unchecked"), for: UIControlState.normal)
                        $0.isChecked = false
                        $0.isEnabled = false }
                
                tracheostomyTubeGroupButton
                    .forEach {
                        $0.isChecked = false
                        $0.setImage(UIImage(named: "nonfilled"), for: UIControlState.normal)
                        $0.isEnabled = false }
                
                self.trachFixTextField.isEnabled = false
                self.trachNoTextField.isEnabled = false
                self.trachFixTextField.text = ""
                self.trachNoTextField.text = ""
                self.cSpineTextField.isEnabled = false
                self.cSpineTextField.text = ""
                
            }else if sender.tag == 177 {
                self.trachFixTextField.isEnabled = true
                self.trachNoTextField.isEnabled = true
                tracheostomyTubeGroupButton
                    .forEach {
                        $0.isChecked = false
                        $0.setImage(UIImage(named: "nonfilled"), for: UIControlState.normal)
                        $0.isEnabled = true }
            }
        }
    }
    
    @IBAction func tracheostomyTubeClick(sender: AnyObject) {
        if airwayGroupButton[9].isChecked {
            tracheostomyTubeGroupButton
                .forEach {
                    if $0.tag == sender.tag {
                        $0.setImage(#imageLiteral(resourceName: "checkmark"), for: UIControlState.normal)
                        $0.isChecked = true
                    }else{
                        $0.setImage(#imageLiteral(resourceName: "nonfilled"), for: UIControlState.normal)
                        $0.isChecked = false
                    } }
        }
        
    }
    
    //MARK:- RESP
    @IBAction func respClick(sender: AnyObject) {
        guard let button = respButtonGroup.first(where: { $0.tag == sender.tag }) else
        {
            return
        }
        
        if button.isChecked {
            button.setImage(#imageLiteral(resourceName: "unchecked"), for: UIControlState.normal)
            button.isChecked = false
            if sender.tag == 159 {
                respButtonGroup
                    .filter { $0.tag != 159 }
                    .forEach {
                        $0.setImage(UIImage(named: "unchecked"), for: UIControlState.normal)
                        $0.isChecked = false
                        $0.isEnabled = true }
            }else if sender.tag == 198 {
                self.ventialtorView.isUserInteractionEnabled = false
                resp2ButtonGroup
                    .forEach {
                        $0.setImage(UIImage(named: "nonfilled"), for: UIControlState.normal)
                        $0.isChecked = false
                        $0.isEnabled = false }
            }else if sender.tag == 165 {
                self.respWheezingTextField.isEnabled = false
            }else if sender.tag == 162 {
                self.respO2CannulaTextField.isEnabled = false
            }else if sender.tag == 163 {
                self.respO2MaskTextField.isEnabled = false
            }else if sender.tag == 164 {
                self.respCollarMaskTextField.isEnabled = false
            }
        }else{
            button.setImage(#imageLiteral(resourceName: "checked"), for: UIControlState.normal)
            button.isChecked = true
            if sender.tag == 159 {
                respButtonGroup
                    .filter { $0.tag != 159 }
                    .forEach {
                        $0.setImage(UIImage(named: "unchecked"), for: UIControlState.normal)
                        $0.isChecked = false
                        $0.isEnabled = false }
                
                resp2ButtonGroup
                    .forEach {
                        $0.setImage(UIImage(named: "nonfilled"), for: UIControlState.normal)
                        $0.isChecked = false
                        $0.isEnabled = false }
                
                self.respWheezingTextField.isEnabled = false
                self.respO2CannulaTextField.isEnabled = false
                self.respO2MaskTextField.isEnabled = false
                self.respCollarMaskTextField.isEnabled = false
                self.respWheezingTextField.text = ""
                self.respO2CannulaTextField.text = ""
                self.respO2MaskTextField.text = ""
                self.respCollarMaskTextField.text = ""
                self.ventialtorView.isUserInteractionEnabled = false
            }else if sender.tag == 198 {
                self.ventialtorView.isUserInteractionEnabled = true
                resp2ButtonGroup
                    .forEach {
                        $0.setImage(UIImage(named: "nonfilled"), for: UIControlState.normal)
                        $0.isChecked = false
                        $0.isEnabled = true }
            }else if sender.tag == 165 {
                self.respWheezingTextField.isEnabled = true
            }else if sender.tag == 162 {
                self.respO2CannulaTextField.isEnabled = true
            }else if sender.tag == 163 {
                self.respO2MaskTextField.isEnabled = true
            }else if sender.tag == 164 {
                self.respCollarMaskTextField.isEnabled = true
            }
        }
    }
    
    @IBAction func resp2Click(sender: AnyObject) {
        resp2ButtonGroup
            .forEach {
                if $0.tag == sender.tag {
                    $0.setImage(#imageLiteral(resourceName: "checkmark"), for: UIControlState.normal)
                    $0.isChecked = true
                }else{
                    $0.setImage(#imageLiteral(resourceName: "nonfilled"), for: UIControlState.normal)
                    $0.isChecked = false
                } }
    }
    
    //MARK:- CVS
    //MARK:- Neuro
    @IBAction func neuroClick(sender: AnyObject) {
        
        if neuroButton.isChecked {
            self.neuroButton.isChecked = false
            self.neuroButton.setImage(UIImage(named: "unchecked"), for: UIControlState.normal)
            self.neuroMButton.isEnabled = true
            self.neuroEButton.isEnabled = true
            self.neuroVButton.isEnabled = true
        }else{
            self.neuroButton.isChecked = true
            self.neuroButton.setImage(UIImage(named: "checked"), for: UIControlState.normal)
            self.neuroMButton.setTitle("0", for: UIControlState.normal)
            self.neuroEButton.setTitle("0", for: UIControlState.normal)
            self.neuroVButton.setTitle("0", for: UIControlState.normal)
            self.neuroMButton.isEnabled = false
            self.neuroEButton.isEnabled = false
            self.neuroVButton.isEnabled = false
        }
    }
    //MARK:- TempC
    @IBAction func tempCClick(sender: AnyObject) {
        tempCGroupButton
            .forEach {
                if $0.tag == sender.tag {
                    $0.setImage(#imageLiteral(resourceName: "checkmark"), for: UIControlState.normal)
                    $0.isChecked = true
                }else{
                    $0.setImage(#imageLiteral(resourceName: "nonfilled"), for: UIControlState.normal)
                    $0.isChecked = false
                } }
    }
    //MARK:- PR/Min
    @IBAction func prminClick(sender: AnyObject) {
        prminGroupButton
            .forEach {
                if $0.tag == sender.tag {
                    $0.setImage(#imageLiteral(resourceName: "checkmark"), for: UIControlState.normal)
                    $0.isChecked = true
                }else{
                    $0.setImage(#imageLiteral(resourceName: "nonfilled"), for: UIControlState.normal)
                    $0.isChecked = false
                } }
    }

    //MARK:- Deformity & Protection
    @IBAction func dpClick(sender: AnyObject) {
        guard let button = DPGroupButton.first(where: { $0.tag == sender.tag }) else
        {
            return
        }
        
        if button.isChecked {
            button.setImage(#imageLiteral(resourceName: "unchecked"), for: UIControlState.normal)
            button.isChecked = false
            if sender.tag == 143 {
                DPGroupButton
                    .filter { $0.tag != 143 }
                    .forEach {
                        $0.setImage(UIImage(named: "unchecked"), for: UIControlState.normal)
                        $0.isChecked = false
                        $0.isEnabled = true }
            }
        }else{
            button.setImage(#imageLiteral(resourceName: "checked"), for: UIControlState.normal)
            button.isChecked = true
            if sender.tag == 143 {
                DPGroupButton
                    .filter { $0.tag != 143 }
                    .forEach {
                        $0.setImage(UIImage(named: "unchecked"), for: UIControlState.normal)
                        $0.isChecked = false
                        $0.isEnabled = false }
            }
        }
    }
    //MARK:- Drains
    @IBAction func drainsClick(sender: AnyObject) {
        guard let button = drainsGroupButton.first(where: { $0.tag == sender.tag }) else
        {
            return
        }
        
        if button.isChecked {
            button.setImage(#imageLiteral(resourceName: "unchecked"), for: UIControlState.normal)
            button.isChecked = false
            if sender.tag == 133 {
                drainsGroupButton
                    .filter { $0.tag != 133 }
                    .forEach {
                        $0.setImage(UIImage(named: "unchecked"), for: UIControlState.normal)
                        $0.isChecked = false
                        $0.isEnabled = true }
            }
            else if sender.tag == 142
            {
                self.drainsOtherTextField.text = ""
                self.drainsOtherTextField.isEnabled = false
            }
        }else{
            button.setImage(#imageLiteral(resourceName: "checked"), for: UIControlState.normal)
            button.isChecked = true
            if sender.tag == 133 {
                drainsGroupButton
                    .filter { $0.tag != 133 }
                    .forEach {
                        $0.setImage(UIImage(named: "unchecked"), for: UIControlState.normal)
                        $0.isChecked = false
                        $0.isEnabled = false }
                self.drainsOtherTextField.isEnabled = false
                self.drainsOtherTextField.text = ""
            }
            else if sender.tag == 142
            {
                self.drainsOtherTextField.isEnabled = true
            }
        }
    }

    //MARK:- MotorPower
    
    //MARK:- pupilRt
    @IBAction func pupilRtClick(sender: AnyObject) {
        pupilRtGroupButton
            .forEach {
                if $0.tag == sender.tag {
                    $0.setImage(#imageLiteral(resourceName: "checkmark"), for: UIControlState.normal)
                    $0.isChecked = true
                }else{
                    $0.setImage(#imageLiteral(resourceName: "nonfilled"), for: UIControlState.normal)
                    $0.isChecked = false
                } }
    }
    
    @IBAction func pupilLtClick(sender: AnyObject) {
        pupilLtGroupButton
            .forEach {
                if $0.tag == sender.tag {
                    $0.setImage(#imageLiteral(resourceName: "checkmark"), for: UIControlState.normal)
                    $0.isChecked = true
                }else{
                    $0.setImage(#imageLiteral(resourceName: "nonfilled"), for: UIControlState.normal)
                    $0.isChecked = false
                } }
    }
    //MARK:- BPmmHg
    @IBAction func BPmmHgClick(sender: AnyObject) {
        BPmmHgGroupButton
            .forEach {
                if $0.tag == sender.tag {
                    $0.setImage(#imageLiteral(resourceName: "checkmark"), for: UIControlState.normal)
                    $0.isChecked = true
                }else{
                    $0.setImage(#imageLiteral(resourceName: "nonfilled"), for: UIControlState.normal)
                    $0.isChecked = false
                } }
    }
    //MARK:- O2Sat
    //MARK:- painScore
    //MARK:- distalPulse
    @IBAction func distalPulseClick(sender: AnyObject) {
        distalPulseGroupButton
            .forEach {
                if $0.tag == sender.tag {
                    $0.setImage(#imageLiteral(resourceName: "checkmark"), for: UIControlState.normal)
                    $0.isChecked = true
                    if sender.tag == 199 {
                        self.distalPulseOtherTextField.isEnabled = true
                    }
                }else{
                    $0.setImage(#imageLiteral(resourceName: "nonfilled"), for: UIControlState.normal)
                    $0.isChecked = false
                    if sender.tag == 199 {
                        self.distalPulseOtherTextField.isEnabled = false
                    }
                }
        }
    }
    //MARK:- Functional Assessment
    @IBAction func painAssToolClick(sender: AnyObject) {
        painAssToolButton
            .forEach {
                if $0.tag == sender.tag {
                    $0.setImage(#imageLiteral(resourceName: "checkmark"), for: UIControlState.normal)
                    $0.isChecked = true
                }else{
                    $0.setImage(#imageLiteral(resourceName: "nonfilled"), for: UIControlState.normal)
                    $0.isChecked = false
                } }
    }
    
    @IBAction func charteristicClick(sender: AnyObject) {
        charateristicButton
            .forEach {
                if $0.tag == sender.tag {
                    $0.setImage(#imageLiteral(resourceName: "checkmark"), for: UIControlState.normal)
                    $0.isChecked = true
                }else{
                    $0.setImage(#imageLiteral(resourceName: "nonfilled"), for: UIControlState.normal)
                    $0.isChecked = false
                } }
        
        if sender.tag == 67 {
            self.otherTextField.isEnabled = true
            _ = self.otherTextField.becomeFirstResponder()
        }else{
            self.otherTextField.text = ""
            self.otherTextField.isEnabled = false
        }
    }
    
    @IBAction func frequencyClick(sender: AnyObject) {
        frequenceButton
            .forEach {
                if $0.tag == sender.tag {
                    $0.setImage(#imageLiteral(resourceName: "checkmark"), for: UIControlState.normal)
                    $0.isChecked = true
                }else{
                    $0.setImage(#imageLiteral(resourceName: "nonfilled"), for: UIControlState.normal)
                    $0.isChecked = false
                } }
    }
    
    //MARK:- LabAssessment
    @IBAction func nsfClick(sender: AnyObject) {
        if nsfButton.isChecked {
            self.nsfButton.setImage(UIImage(named: "unchecked_white"), for: UIControlState.normal)
            self.nsfButton.isChecked = false
            self.labAssessmentView.isUserInteractionEnabled = true
        }else{
            self.nsfButton.setImage(UIImage(named: "checked_white"), for: UIControlState.normal)
            self.nsfButton.isChecked = true
            self.labAssessmentView.isUserInteractionEnabled = false
        }
    }
    @IBAction func pneunothraxClick(sender: AnyObject) {
        LAPneumothraxGroupButton
            .forEach {
                if $0.tag == sender.tag {
                    $0.setImage(#imageLiteral(resourceName: "checkmark"), for: UIControlState.normal)
                    $0.isChecked = true
                }else{
                    $0.setImage(#imageLiteral(resourceName: "nonfilled"), for: UIControlState.normal)
                    $0.isChecked = false
                } }
    }
    
    @IBAction func pneumocephalusClick(sender: AnyObject) {
        LAPneumocephalusGroupButton
            .forEach {
                if $0.tag == sender.tag {
                    $0.setImage(#imageLiteral(resourceName: "checkmark"), for: UIControlState.normal)
                    $0.isChecked = true
                }else{
                    $0.setImage(#imageLiteral(resourceName: "nonfilled"), for: UIControlState.normal)
                    $0.isChecked = false
                } }
    }
    
    //MARK:- Other Physical
    
    @IBAction func addPosition(sender: AnyObject) {
        if self.otherPhysicalNameTextField.text != "" && self.otherPhycicalPositionButton.titleLabel?.text != "" {
            if flightPositionItem == nil {
                self.flightPersonViewModel.addOrUpdate(item: ["name":self.otherPhysicalNameTextField.text!,"position":self.otherPhycicalPositionButton.titleLabel!.text!])
            }else{
                let id = flightPositionItem!["id"]
                self.flightPersonViewModel.addOrUpdate(item: ["flightPersonId":id!,"name":self.otherPhysicalNameTextField.text!,"position":otherPhycicalPositionButton.titleLabel!.text!])
            }
            
        }else{
            let alertEdit = UIAlertController(title: "Can't Add Flight Person", message: "Please input all data.", preferredStyle: UIAlertControllerStyle.alert)
            alertEdit.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (alert) in
            }))
            
            present(alertEdit, animated: true, completion: nil)
        }
    }
    
    func actionFlightPerosonData(action : DataAction,indexPath : IndexPath) {
        
        let item = self.flightPersonViewModel.listItem(index: indexPath.row)
        if action == .addOrUpdate {
            self.addOtherPhysicalButton.setTitle("Edit", for: UIControlState.normal)
            self.otherPhysicalNameTextField.text = item["name"]
            self.otherPhycicalPositionButton.setTitle(item["position"], for: UIControlState.normal)
            flightPositionItem = item
        }else{
            let alert = UIAlertController(title: "Remove", message: "You want to remove this item?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: { (alert) in
                
            }))
            
            alert.addAction(UIAlertAction(title: "Remove", style: UIAlertActionStyle.destructive, handler: { (alert) in
                self.flightPersonViewModel.remove(id: item["id"]!)
                
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func savePreflight(sender: AnyObject) {
        self.savePreflightTolocal()
        let alert = UIAlertController(title: "Save Success", message: "Preflight has been save.", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (alert) in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func savePreflightTolocal(){
        let consultResult = ConsultResult()
        //GA
        var gaArray = [DetailItem]()
        gaGroupButton
            .filter { $0.isChecked }
            .forEach {
                let item = DetailItem()
                item.value = $0.tag
                gaArray.append(item) }
        
        consultResult.sedatedDrung = self.gaSedatedDrugTextField.text!
        consultResult.lastDose = self.gaSedatedLastDiseAtTextField.text!
        consultResult.restraintTime = self.gaRestraintTimeTextField.text!
        
        consultResult.ga = gaArray
        
        //Airway
        var airwayArray = [DetailItem]()
        airwayGroupButton
            .filter { $0.isChecked }
            .forEach {
                let item = DetailItem()
                item.value = $0.tag
                airwayArray.append(item) }
        
        consultResult.airway = airwayArray
        consultResult.cspine = self.cSpineTextField.text!
        consultResult.tubeFix = self.trachFixTextField.text!
        consultResult.tubeNo = self.trachNoTextField.text!
        consultResult.tubeCuffCheckValue = self.tracheostomyTubeGroupButton[0].isChecked ? 166 : 167
        
        //RESP
        var respArray = [DetailItem]()
        respButtonGroup
            .filter { $0.isChecked }
            .forEach {
                var respLPM = "0"
                if $0.tag == 165 {
                    respLPM = self.respWheezingTextField.text!
                }else if $0.tag == 162 {
                    respLPM = self.respO2CannulaTextField.text!
                }else if $0.tag == 163 {
                    respLPM = self.respO2MaskTextField.text!
                }else if $0.tag == 164 {
                    respLPM = self.respCollarMaskTextField.text!
                }
                let item = DetailItem()
                item.value = $0.tag
                item.RESP_LPM = respLPM
                respArray.append(item) }
        
        consultResult.resp = respArray
        
        resp2ButtonGroup
            .filter { $0.isChecked }
            .forEach { consultResult.ventialValue = $0.tag }
        
        consultResult.ventialRate = self.respRateMinTextField.text!
        consultResult.ventialE = self.respETextField.text!
        consultResult.ventialI = self.respITextField.text!
        consultResult.ventialPS = self.respPSTextField.text!
        consultResult.ventialVT = self.respVtTextField.text!
        consultResult.ventialFIO2 = self.respFiO2TextField.text!
        consultResult.ventialPEEP = self.respPEEPTextField.text!
        consultResult.ventialPeakFlow = self.respPeakFlowTextField.text!
        
        //CVS
        consultResult.csvDisplay = self.cvsButton.currentTitle!
        
        
        //Nero
        if neuroButton.isChecked {
            consultResult.neroNSFCheck = "True"
        }else{
            consultResult.neroNSFCheck = "False"
        }
        
        consultResult.neroMDisplay = self.neuroMButton.currentTitle!
        consultResult.neroEDisplay = self.neuroEButton.currentTitle!
        consultResult.neroVDisplay = self.neuroVButton.currentTitle!
        
        //MotoPower
        consultResult.motorPowerTL = self.motorPowerButton[0].currentTitle!
        consultResult.motorPowerTR = self.motorPowerButton[1].currentTitle!
        consultResult.motorPowerBL = self.motorPowerButton[2].currentTitle!
        consultResult.motorPowerBR = self.motorPowerButton[3].currentTitle!
        
        //pupil
        consultResult.pupilLTMin = self.pupilLtmmTextField.text!
        consultResult.pupilRTMin = self.pupilRtmmTextField.text!
        consultResult.pupilRTTypeValue = self.pupilRtGroupButton[0].isChecked ? 32 : 33
        consultResult.pupilLTTypeValue = self.pupilLtGroupButton[0].isChecked ? 32 : 33
        
        //TempC
        
        tempCGroupButton
            .filter { $0.isChecked }
            .forEach { consultResult.tempCheck = "\($0.tag)" }
        
        consultResult.tempValue = self.tempCTextField.text!
        let item = DetailItem()
        item.display = self.tempCSelectButton.currentTitle!
        consultResult.tempType = [item]
        
        //PR/Min
        prminGroupButton
            .filter { $0.isChecked }
            .forEach { consultResult.prMin = "\($0.tag)" }
        
        consultResult.prMinVal = self.prminTextField.text!
        
        //BPmmHG
        BPmmHgGroupButton
            .filter { $0.isChecked }
            .forEach { consultResult.bmMinHg = "\($0.tag)" }
        
        consultResult.bmVal1 = self.BPmmHgtextField.text!
        consultResult.bmVal2 = self.BPmmHg2TextField.text!
        
        //Deformity & Protection
        var dfArray = [DetailItem]()
        DPGroupButton
            .filter { $0.isChecked }
            .forEach {
                let item = DetailItem()
                item.value = $0.tag
                dfArray.append(item) }
        
        consultResult.deform = dfArray
        
        //O2Sat
        consultResult.o2Sat = self.O2SatTextField.text!
        
        //pain score
        consultResult.painScore = self.painScoreButton.currentTitle!
        
        //functional assessment
        consultResult.walkDisplay = self.FAWalkButton.currentTitle!
        consultResult.sitDisplay = self.FASitButton.currentTitle!
        consultResult.eatDisplay = self.FAEatButton.currentTitle!
        consultResult.urinationDisplay = self.FAUrinationButton.currentTitle!
        consultResult.bowelMovmentDisplay = self.FABowlMovementButton.currentTitle!
        
        //Drain
        var drainArray = [DetailItem]()
        drainsGroupButton
            .filter { $0.isChecked }
            .forEach {
                let item = DetailItem()
                item.value = $0.tag
                drainArray.append(item) }
        
        consultResult.drains = drainArray
        consultResult.drainOther = self.drainsOtherTextField.text!
        
        //dispal
        distalPulseGroupButton
            .filter { $0.isChecked }
            .forEach { consultResult.distalPulseValue = $0.tag }
        
        consultResult.distalOther = self.distalPulseOtherTextField.text!
        
        //Lab Assessment
        consultResult.labNSFCheck = self.nsfButton.isChecked ? "True" : "False"
        consultResult.hb = self.LAHBTextField.text!
        consultResult.hct = self.LAHCTTextField.text!
        consultResult.wbc = self.LAWBCTextField.text!
        consultResult.plt = self.LAPLTTextField.text!
        consultResult.pmn = self.LAPMNTextField.text!
        consultResult.lym = self.LALYMTextField.text!
        consultResult.eo = self.LAEOTextField.text!
        consultResult.pt = self.LAPTTextField.text!
        consultResult.ptt = self.LAPTTTextField.text!
        consultResult.inr = self.LAINRTextField.text!
        consultResult.na = self.LANATextField.text!
        consultResult.k = self.LAKTextField.text!
        consultResult.cl = self.LACLTextField.text!
        consultResult.co2 = self.LACO2TextField.text!
        consultResult.bun = self.LABUNTextField.text!
        consultResult.cr = self.LACRTextField.text!
        consultResult.bs = self.LABSTextField.text!
        consultResult.cxr = self.LACXRTextField.text!
        consultResult.ctBrain = self.LACTBrainTextField.text!
        consultResult.labOther = self.LAOtherTextField.text!
        consultResult.pneumocepha = self.LAPneumocephalusGroupButton[0].isChecked ?  "True" : "False"
        consultResult.pneumotholax = self.LAPneumothraxGroupButton[0].isChecked ?  "True" : "False"
        
        let otherData = OtherPreflightInfo()
        otherData.caseHospital = self.hospitalTextField.text!
        otherData.caseVisitDate = self.visitDateTextField.text!
        otherData.caseSymptomDate = self.symptomTextField.text!
        otherData.aircraftName = self.aircraftButton.currentTitle!
        otherData.physicalOther = self.otherPhysicalOtherTextField.text!
        otherData.currentTreatment = self.otherPhysicalCurrentTreatmentTextField.text!
        otherData.escotComment = self.otherPhysicalExcotCommentTextField.text!
        otherData.brief = self.briefHistoryTextField.text!
        otherData.caseDicgnosis = self.capitalLetterTextField.text!
        let vm = caseResultViewModel()
        vm.savePreflight(data: consultResult,otherData: otherData)
        
        //save pain assessment tool
        if let flightInfo = vm.loadOnboard()
        {
            var painId = flightInfo.painassessmentTypeId
            painAssToolButton
                .filter { $0.isChecked }
                .forEach { painId = $0.tag }
            
            let freId = frequenceButton[0].isChecked ? 18 : (frequenceButton[1].isChecked ? 19 : 0)
            var charID = 0
            
            charateristicButton
                .filter { $0.isChecked }
                .forEach { charID = $0.tag }
            
            flightInfo.characteristicId = charID
            flightInfo.characOther = self.otherTextField.text!
            flightInfo.frequencyId = freId
            
            flightInfo.painassessmentTypeId = painId
            flightInfo.location = self.locationTextField.text!
            flightInfo.duration = self.durationTextField.text!
            vm.saveOnboard(data: flightInfo,state: "Preflight")
        }
        else
        {
            let flightInfo = FlightInfoResult()
            var painId = flightInfo.painassessmentTypeId
            painAssToolButton
                .filter { $0.isChecked }
                .forEach { painId = $0.tag }
            
            let freId = frequenceButton[0].isChecked ? 18 : (frequenceButton[1].isChecked ? 19 : 0)
            var charID = 0
            
            charateristicButton
                .filter { $0.isChecked }
                .forEach { charID = $0.tag }
            
            flightInfo.characteristicId = charID
            flightInfo.characOther = self.otherTextField.text!
            flightInfo.frequencyId = freId
            
            flightInfo.painassessmentTypeId = painId
            flightInfo.location = self.locationTextField.text!
            flightInfo.duration = self.durationTextField.text!
            vm.saveOnboard(data: flightInfo,state: "Preflight")
        }
    }
    
    //MARK:- initDataConsultResult
    func initDataConsultResult(){
        let vm = caseResultViewModel()
        let otherData = vm.loadPreflight().other
        self.hospitalTextField.text = otherData.caseHospital
        self.visitDateTextField.text = otherData.caseVisitDate
        self.symptomTextField.text = otherData.caseSymptomDate
        self.aircraftButton.setTitle(otherData.aircraftName, for: UIControlState.normal)
        self.capitalLetterTextField.text = otherData.caseDicgnosis
        let caseRes = vm.loadPreflight().caseResult
        
        if let preflight = caseRes.preflight.first {
            self.otherPhysicalOtherTextField.text = preflight.physicalOther
            self.otherPhysicalCurrentTreatmentTextField.text = preflight.currentTreatment
            self.otherPhysicalExcotCommentTextField.text = preflight.escotComment
            self.briefHistoryTextField.text = preflight.brief
            
            
            //intervention 
            if self.interventionViewModel.numberOfItems() == 0 {
                for item in caseRes.interventions {
                    let data : [String : Any] = ["interventionId":item.id,"intervention":item.detail,"date":item.date]
                    self.interventionViewModel.consultInit(item: data)
                }
            }
            
            //report
            if self.summaryViewModel.numberOfItems() == 0 {
                for item in caseRes.summaryReport {
                    let data : [String : Any] = ["id":item.id,"title":item.title,"path":item.path]
                    self.summaryViewModel.consultInit(item: data)
                }
            }
            
            //GA
            preflight
                .gaReccords
                .forEach { item in
                    let button = gaGroupButton.first(where: { $0.tag == item.id })
                    button?.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
                    button?.isChecked = true
                    
                    if item.id == 178
                    {
                        gaGroupButton
                            .filter { $0.tag != 178 }
                            .forEach {
                                $0.isChecked = false
                                $0.isEnabled = false }
                    }
                    else if item.id == 186
                    {
                        self.gaSedatedDrugTextField.text = preflight.sedatedDrung
                        self.gaSedatedLastDiseAtTextField.text = preflight.lastDose
                        self.gaSedatedLastDiseAtTextField.isEnabled = true
                        self.gaSedatedDrugTextField.isEnabled = true
                    }
                    else if item.id == 187
                    {
                        self.gaRestraintTimeTextField.text = preflight.restraintTime
                        self.gaRestraintTimeTextField.isEnabled = true
                    } }
            
            //Airway
            preflight
                .airwayReccords
                .forEach { item in
                    let button = airwayGroupButton.first(where: { $0.tag == item.id })
                    button?.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
                    button?.isChecked = true
                    
                    if item.id == 168
                    {
                        airwayGroupButton
                            .filter { $0.tag != 168 }
                            .forEach {
                                $0.isChecked = false
                                $0.isEnabled = false }
                    }
                    else if item.id == 177
                    {
                        self.trachFixTextField.isEnabled = true
                        self.trachNoTextField.isEnabled = true
                        self.trachFixTextField.text = preflight.tubeFix
                        self.trachNoTextField.text = preflight.tubeNo
                        for button in tracheostomyTubeGroupButton {
                            button.isEnabled = true
                        }
                        
                        if preflight.tubeCuffCheckId == 166 {
                            self.tracheostomyTubeGroupButton[0].setImage(#imageLiteral(resourceName: "checkmark"), for: UIControlState.normal)
                        }else if preflight.tubeCuffCheckId == 167 {
                            self.tracheostomyTubeGroupButton[1].setImage(#imageLiteral(resourceName: "checkmark"), for: UIControlState.normal)
                        }
                    } }
            
            self.cSpineTextField.text = preflight.cspine
            
            
            //RESP
            preflight
                .respReccords
                .forEach { item in
                    let button = respButtonGroup.first(where: { $0.tag == item.id })
                    button?.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
                    button?.isChecked = true
                    
                    if item.id == 159
                    {
                        respButtonGroup
                            .filter { $0.tag != 159 }
                            .forEach {
                                $0.isChecked = false
                                $0.isEnabled = false }
                    }
                    else if item.id == 165 {
                        self.respWheezingTextField.text = item.lpm
                        self.respWheezingTextField.isEnabled = true
                    }else if item.id == 162 {
                        self.respO2CannulaTextField.text = item.lpm
                        self.respO2CannulaTextField.isEnabled = true
                    }else if item.id == 163 {
                        self.respO2MaskTextField.text = item.lpm
                        self.respO2MaskTextField.isEnabled = true
                    }else if item.id == 164 {
                        self.respCollarMaskTextField.text = item.lpm
                        self.respCollarMaskTextField.isEnabled = true
                    }else if item.id == 198 {
                        self.ventialtorView.isUserInteractionEnabled = true
                        resp2ButtonGroup
                            .forEach {
                                $0.isEnabled = true
                                if preflight.ventialId == $0.tag
                                {
                                    $0.isChecked = true
                                    $0.setImage(#imageLiteral(resourceName: "checkmark"), for: .normal)
                                } }
                        self.respRateMinTextField.text = preflight.ventialRate
                        self.respETextField.text = preflight.ventialE
                        self.respITextField.text = preflight.ventialI
                        self.respPSTextField.text = preflight.ventialPS
                        self.respVtTextField.text = preflight.ventialVT
                        self.respFiO2TextField.text = preflight.ventialFIO2
                        self.respPEEPTextField.text = preflight.ventialPeep
                        self.respPeakFlowTextField.text = preflight.ventialPeakFlow
                    } }
            
            //CVS
            let csvTitle = try! Realm().objects(MasterData.self).filter("masterID == \(preflight.csvId == 0 ? 54 : preflight.csvId)").first?.name
            self.cvsButton.setTitle(csvTitle ?? "NSF", for: UIControlState.normal)
            
            //Nero
            if preflight.neroNSFCheck {
                self.neuroButton.setImage(#imageLiteral(resourceName: "checked"), for: UIControlState.normal)
                self.neuroButton.isChecked = true
                self.neuroMButton.isEnabled = false
                self.neuroEButton.isEnabled = false
                self.neuroVButton.isEnabled = false
            }else{
                let neroE = try! Realm().objects(MasterData.self).filter("masterID == \(preflight.neroE)").first?.name ?? "0"
                let neroM = try! Realm().objects(MasterData.self).filter("masterID == \(preflight.neroM)").first?.name ?? "0"
                let neroV = try! Realm().objects(MasterData.self).filter("masterID == \(preflight.neroV)").first?.name ?? "0"
                self.neuroMButton.setTitle(neroM, for: UIControlState.normal)
                self.neuroEButton.setTitle(neroE, for: UIControlState.normal)
                self.neuroVButton.setTitle(neroV, for: UIControlState.normal)
            }
            
            //MotoPower
            self.motorPowerButton[0].setTitle("\(preflight.mpTL)", for: UIControlState.normal)
            self.motorPowerButton[1].setTitle("\(preflight.mpTR)", for: UIControlState.normal)
            self.motorPowerButton[2].setTitle("\(preflight.mpBL)", for: UIControlState.normal)
            self.motorPowerButton[3].setTitle("\(preflight.mpBR)", for: UIControlState.normal)
            
            //pupil
            self.pupilLtmmTextField.text  = preflight.pupilLTMin
            self.pupilRtmmTextField.text  = preflight.pupilRTMin
            
            if preflight.pupilRTTypeId == 32 {
                self.pupilRtGroupButton[0].isChecked = true
                self.pupilRtGroupButton[0].setImage(#imageLiteral(resourceName: "checkmark"), for: UIControlState.normal)
            }else{
                self.pupilRtGroupButton[1].isChecked = true
                self.pupilRtGroupButton[1].setImage(#imageLiteral(resourceName: "checkmark"), for: UIControlState.normal)
            }
            
            if preflight.pupilLTTypeId == 32 {
                self.pupilLtGroupButton[0].isChecked = true
                self.pupilLtGroupButton[0].setImage(#imageLiteral(resourceName: "checkmark"), for: UIControlState.normal)
            }else{
                self.pupilLtGroupButton[0].isChecked = true
                self.pupilLtGroupButton[1].setImage(#imageLiteral(resourceName: "checkmark"), for: UIControlState.normal)
            }
            
            //TempC
            tempCGroupButton
                .filter { $0.tag == preflight.tempCheck }
                .forEach {
                    $0.isChecked = true
                    $0.setImage(#imageLiteral(resourceName: "checkmark"), for: .normal) }
            
            self.tempCTextField.text = preflight.tempValue
            let tempDisplay = try! Realm().objects(MasterData.self).filter("masterID == \(preflight.tempType)").first?.name ?? "°C"
            self.tempCSelectButton.setTitle(tempDisplay, for: UIControlState.normal)
            
            //PR/Min
            prminGroupButton
                .filter { $0.tag == Int(preflight.prMin) }
                .forEach {
                    $0.isChecked = true
                    $0.setImage(#imageLiteral(resourceName: "checkmark"), for: .normal) }
            
            self.prminTextField.text = preflight.prMinDetail
            
            //BPmmHG
            BPmmHgGroupButton
                .filter { $0.tag == preflight.bmMinHG }
                .forEach {
                    $0.isChecked = true
                    $0.setImage(#imageLiteral(resourceName: "checkmark"), for: .normal) }
            
            self.BPmmHgtextField.text = "\(preflight.bmVal1)"
            self.BPmmHg2TextField.text = "\(preflight.bmVal2)"
            
            //Deformity & Protection
            preflight
                .deformReccords
                .forEach { item in
                    let button = DPGroupButton.first(where: { $0.tag == item.id })
                    button?.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
                    button?.isChecked = true
                    
                    if item.id == 143  {
                        DPGroupButton
                            .filter { $0.tag != 143 }
                            .forEach {
                                $0.isChecked = false
                                $0.isEnabled = false }
                    } }
            
            //O2Sat
            self.O2SatTextField.text = "\(preflight.o2Sat)"
            
            //pain score
            self.painScoreButton.setTitle(preflight.painScore, for: UIControlState.normal)
            
            //functional assessment
            let walkDisplay = try! Realm().objects(MasterData.self).filter("masterID == \(preflight.walkId)").first?.name ?? "-"
            let sitDisplay = try! Realm().objects(MasterData.self).filter("masterID == \(preflight.sitId)").first?.name ?? "-"
            let eatDisplay = try! Realm().objects(MasterData.self).filter("masterID == \(preflight.eatId)").first?.name ?? "-"
            let urinationDisplay = try! Realm().objects(MasterData.self).filter("masterID == \(preflight.urinationId)").first?.name ?? "-"
            let bowelMovmentDisplay = try! Realm().objects(MasterData.self).filter("masterID == \(preflight.bowelMovmentId)").first?.name ?? "-"
            
            self.FAWalkButton.setTitle(walkDisplay, for: UIControlState.normal)
            self.FASitButton.setTitle(sitDisplay, for: UIControlState.normal)
            self.FAEatButton.setTitle(eatDisplay, for: UIControlState.normal)
            self.FAUrinationButton.setTitle(urinationDisplay, for: UIControlState.normal)
            self.FABowlMovementButton.setTitle(bowelMovmentDisplay, for: UIControlState.normal)
            
            //Drain
            preflight
                .drainsReccords
                .forEach { item in
                    let button = drainsGroupButton.first(where: { $0.tag == item.id })
                    button?.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
                    button?.isChecked = true
                    
                    if item.id == 133  {
                        drainsGroupButton
                            .filter { $0.tag != 133 }
                            .forEach {
                                $0.isChecked = false
                                $0.isEnabled = false }
                    }
                    else if item.id == 142 {
                        self.drainsOtherTextField.isEnabled = true
                        self.drainsOtherTextField.text = preflight.drainOther
                    } }
            
            //dispal
            distalPulseGroupButton
                .filter { $0.tag == preflight.distalPluseId }
                .forEach {
                    $0.isChecked = true
                    $0.setImage(#imageLiteral(resourceName: "checkmark"), for: .normal)
                    
                    if $0.tag == 199 {
                        self.distalPulseOtherTextField.isEnabled = true
                        self.distalPulseOtherTextField.text = preflight.distalOther
                    } }
            
            //Pain Assessment
            if let od = vm.loadOnboard() {
                self.locationTextField.text = od.location
                self.durationTextField.text = od.duration
                painAssToolButton
                    .filter { $0.tag == od.painassessmentTypeId }
                    .forEach {
                        $0.isChecked = true
                        $0.setImage(#imageLiteral(resourceName: "checkmark"), for: .normal) }
                
                self.otherTextField.text = od.characOther
                
                charateristicButton
                    .filter { $0.tag == od.characteristicId }
                    .forEach {
                        $0.isChecked = true
                        $0.setImage(#imageLiteral(resourceName: "checkmark"), for: .normal) }
                
                
                frequenceButton
                    .filter { $0.tag == od.frequencyId }
                    .forEach {
                        $0.isChecked = true
                        $0.setImage(#imageLiteral(resourceName: "checkmark"), for: .normal) }
            }
            
            //Lab Assessment
            if preflight.labNSFCheck {
                self.nsfButton.isChecked = true
                self.nsfButton.setImage(#imageLiteral(resourceName: "checked_white"), for: UIControlState.normal)
                self.labAssessmentView.isUserInteractionEnabled = false
            }else{
                self.LAHBTextField.text = preflight.hb
                self.LAHCTTextField.text = preflight.hct
                self.LAWBCTextField.text = preflight.wbc
                self.LAPLTTextField.text = preflight.plt
                self.LAPMNTextField.text = preflight.pmn
                self.LALYMTextField.text = preflight.lym
                self.LAEOTextField.text = preflight.eo
                self.LAPTTextField.text = preflight.pt
                self.LAPTTTextField.text = preflight.ptt
                self.LAINRTextField.text = preflight.inr
                self.LANATextField.text = preflight.na
                self.LAKTextField.text = preflight.k
                self.LACLTextField.text = preflight.cl
                self.LACO2TextField.text = preflight.co2
                self.LABUNTextField.text = preflight.bun
                self.LACRTextField.text = preflight.cr
                self.LABSTextField.text = preflight.bs
                self.LACXRTextField.text = preflight.cxr
                self.LACTBrainTextField.text = preflight.ctBrain
                self.LAOtherTextField.text = preflight.labOther
            }
            
            if preflight.pneumocephalus {
                self.LAPneumocephalusGroupButton[0].isChecked = true
                self.LAPneumocephalusGroupButton[0].setImage(#imageLiteral(resourceName: "checkmark"), for: UIControlState.normal)
            }else{
                self.LAPneumocephalusGroupButton[1].isChecked = true
                self.LAPneumocephalusGroupButton[1].setImage(#imageLiteral(resourceName: "checkmark"), for: UIControlState.normal)
            }
            
            if preflight.pneumothorax {
                self.LAPneumothraxGroupButton[0].isChecked = true
                self.LAPneumothraxGroupButton[0].setImage(#imageLiteral(resourceName: "checkmark"), for: UIControlState.normal)
            }else{
                self.LAPneumothraxGroupButton[1].isChecked = true
                self.LAPneumothraxGroupButton[1].setImage(#imageLiteral(resourceName: "checkmark"), for: UIControlState.normal)
            }
            
        }
    }
    
}

//MARK:-
extension PreFlightViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

extension PreFlightViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == interventionTableView {
            if self.interventionViewModel.numberOfItems() == 0 {
                return 1
            }
            
            return self.interventionViewModel.numberOfItems()
        }else if tableView == self.otherPhysicalTableView{
            if self.flightPersonViewModel.numberOfItems() == 0 {
                return 1
            }
            
            return self.flightPersonViewModel.numberOfItems()
        }else if tableView == self.sumaryReportTableView{
            if self.summaryViewModel.numberOfItems() == 0 {
                return 1
            }
            
            return self.summaryViewModel.numberOfItems()
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == interventionTableView {
            var cell = tableView.dequeueReusableCell(withIdentifier: "dataCell") as! InterventionTableViewCell
            
            cell.layoutMargins = UIEdgeInsets.zero
            
            if self.interventionViewModel.numberOfItems() == 0 {
                cell = tableView.dequeueReusableCell(withIdentifier: "noDataCell") as! InterventionTableViewCell
            }else{
                let item = self.interventionViewModel.listItem(index: indexPath.row)
                cell.idLabel.text = "\(indexPath.row + 1)"
                cell.interventionLabel.text = item["intervention"]
                cell.dateLabel.text = item["date"]
                cell.leftButtons = [MGSwipeButton(title: "Edit", backgroundColor: Material.Color.blue.accent3, callback: {
                    (sender: MGSwipeTableCell!) -> Bool in
                    self.actionInterventionData(action: .addOrUpdate, indexPath: indexPath)
                    _ = self.interventionTextField.becomeFirstResponder()
                    return true
                })]
                
                cell.rightButtons = [MGSwipeButton(title: "Delete", backgroundColor: Material.Color.red.accent3, callback: {
                    (sender: MGSwipeTableCell!) -> Bool in
                    self.actionInterventionData(action: .delete, indexPath: indexPath)
                    return true
                })]
                
                cell.leftExpansion.buttonIndex = 0
                cell.rightExpansion.buttonIndex = 0
            }
            
            
            return cell
        }else if tableView == sumaryReportTableView {
            var cell = tableView.dequeueReusableCell(withIdentifier: "dataCell") as! SummaryReportTableViewCell
            cell.layoutMargins = UIEdgeInsets.zero
            
            if self.summaryViewModel.numberOfItems() == 0 {
                cell = tableView.dequeueReusableCell(withIdentifier: "nodataCell") as! SummaryReportTableViewCell
            }else{
                let item = self.summaryViewModel.listItem(index: indexPath.row)
                cell.noLabel.text = "\(indexPath.row + 1)"
                cell.titleReportLabel.text = item["title"]
                cell.openFileButton.tag = indexPath.row
                
                
                
                if self.summaryViewModel.fromLocal(index: indexPath.row) {
                    cell.rightButtons = [MGSwipeButton(title: "Delete", backgroundColor: Material.Color.red.accent3, callback: {
                        (sender: MGSwipeTableCell!) -> Bool in
                        self.actionSummaryReport(action: .delete, indexPath: indexPath)
                        return true
                    })]
                    cell.leftButtons = [MGSwipeButton(title: "View", backgroundColor: Material.Color.green.accent4, callback: {
                        (sender: MGSwipeTableCell!) -> Bool in
                        self.actionSummaryReport(action: .list, indexPath: indexPath)
                        return true
                    }),MGSwipeButton(title: "Change", backgroundColor: Material.Color.blue.accent3, callback: {
                        (sender: MGSwipeTableCell!) -> Bool in
                        self.actionSummaryReport(action: .addOrUpdate, indexPath: indexPath)
                        return true
                    })]
                }else{
                    cell.leftButtons = [MGSwipeButton(title: "View", backgroundColor: Material.Color.green.accent4, callback: {
                        (sender: MGSwipeTableCell!) -> Bool in
                        self.actionSummaryReport(action: .list, indexPath: indexPath)
                        return true
                    })]
                }
                cell.leftExpansion.buttonIndex = 0
                cell.rightExpansion.buttonIndex = 0
                
                
            }
            
            
            
            return cell
        }else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "dataCell") as! EmployeeTableViewCell
            cell.layoutMargins = UIEdgeInsets.zero
            
            if self.flightPersonViewModel.numberOfItems() == 0 {
                cell = tableView.dequeueReusableCell(withIdentifier: "noDataCell") as! EmployeeTableViewCell
            }else{
                let item = self.flightPersonViewModel.listItem(index: indexPath.row)
                cell.idLabel.text = "\(indexPath.row + 1)"
                cell.nameLabel.text = item["name"]
                cell.positionLabel.text = item["position"]
                cell.leftButtons = [MGSwipeButton(title: "Edit", backgroundColor: Material.Color.blue.accent3, callback: {
                    (sender: MGSwipeTableCell!) -> Bool in
                    self.actionFlightPerosonData(action: .addOrUpdate, indexPath: indexPath)
                    _ = self.otherPhysicalNameTextField.becomeFirstResponder()
                    return true
                })]
                
                cell.rightButtons = [MGSwipeButton(title: "Delete", backgroundColor: Material.Color.red.accent3, callback: {
                    (sender: MGSwipeTableCell!) -> Bool in
                    self.actionFlightPerosonData(action: .delete, indexPath: indexPath)
                    return true
                })]
                
                cell.leftExpansion.buttonIndex = 0
                cell.rightExpansion.buttonIndex = 0
            }
            
            return cell
        }
        
    }
}

extension PreFlightViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension PreFlightViewController: TextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = CharacterSet(charactersIn:"0123456789.").inverted
        let compSepByCharInSet = string.components(separatedBy:aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
        
    }
}

extension PreFlightViewController:ReaderViewControllerDelegate {
    func dismiss(_ viewController: ReaderViewController!) {
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
    }
}

extension PreFlightViewController {
    
    func getDocumentsDirectory() -> NSString {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        return documentsPath
    }
    
    func randomStringWithLength (len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for _ in 0 ..< len {
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }
        
        return randomString
    }
    
    func alertReportImageDescription(pickedImage:UIImage){
        let alert = UIAlertController(title: "Input image description", message: "Enter a text", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "Description"
            if self.summaryViewModel.selectIndex != 0 {
                textField.text = self.summaryViewModel.getTitle(index: self.summaryViewModel.selectIndex)
            }
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
        }))
        
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            if let data = UIImagePNGRepresentation(pickedImage) {
                let profile = CustomerSingleton.sharedInstance.customerProfile
                var imageName = "\(profile.caseId)\(profile.customerId)\(self.randomStringWithLength(len: 16)).png"
                var id = 0
                if self.summaryViewModel.selectIndex != 0 {
                    imageName = "\(self.summaryViewModel.getImageName(index: self.summaryViewModel.selectIndex))"
                    id = self.summaryViewModel.getIdReport(index: self.summaryViewModel.selectIndex)
                }
                
                
                let imagePath = self.getDocumentsDirectory().appendingPathComponent(imageName)
                let path = URL(fileURLWithPath: imagePath)
                try! data.write(to: path, options: [.atomicWrite ])
                
                var item = ["title":textField.text!,"path":imageName]
                if id != 0 {
                    item["id"] = "\(id)"
                }
                self.summaryViewModel.addOrUpdate(item: item)
            }
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
