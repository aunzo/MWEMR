import UIKit
import Material
import ActionSheetPicker_3_0

class AssessmentViewController: UIViewController {

    @IBOutlet weak var customerView: UIView!
    @IBOutlet weak var flightInfomationView: UIView!
    
    //CustomerProfile
    @IBOutlet weak var customerIDLabel: UILabel!
    @IBOutlet weak var customerFullnameLabel: UILabel!
    @IBOutlet weak var customerBirthDayLabel: UILabel!
    @IBOutlet weak var customerGenderLabel: UILabel!
    @IBOutlet weak var customerAgeLabel: UILabel!
    
    //FlightInfomation
    @IBOutlet weak var takeOffTextField: TextField!
    @IBOutlet weak var takeOffText2Field: TextField!
    @IBOutlet weak var fromAirportTextField: TextField!
    @IBOutlet weak var fromAirportText2Field: TextField!
    @IBOutlet weak var landingTextField: TextField!
    @IBOutlet weak var landingText2Field: TextField!
    @IBOutlet weak var toAirportTextField: TextField!
    @IBOutlet weak var toAirportText2Field: TextField!
    @IBOutlet weak var ambulancePickupTextField: TextField!
    @IBOutlet weak var ambulancePickupText2Field: TextField!
    @IBOutlet weak var ArrivalAtHosTextField: TextField!
    @IBOutlet weak var handOverAtText2Field: TextField!
    @IBOutlet weak var leavingFromHosTextField: TextField!
    @IBOutlet weak var timeText2Field: TextField!
    @IBOutlet weak var givedByTextField: TextField!
    @IBOutlet weak var givedByText2Field: TextField!
    @IBOutlet weak var recievedByTextField: TextField!
    @IBOutlet weak var recievedByText2Field: TextField!
    @IBOutlet var recieveItemButton: [UIButton]!
    @IBOutlet var tranferItemButton: [UIButton]!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        customerView.layer.cornerRadius = 5
        customerView.layer.shadowColor = UIColor.black.cgColor
        customerView.layer.shadowOffset = CGSize(width:1.0,height:1.0)
        customerView.layer.shadowOpacity = 0.5
        customerView.layer.shadowRadius = 1.5
        
        flightInfomationView.layer.cornerRadius = 5
        flightInfomationView.layer.shadowColor = UIColor.black.cgColor
        flightInfomationView.layer.shadowOffset = CGSize(width:1.0,height:1.0)
        flightInfomationView.layer.shadowOpacity = 0.5
        flightInfomationView.layer.shadowRadius = 1.5
        
        let profile = CustomerSingleton.sharedInstance.customerProfile
        self.customerIDLabel.text = profile.personalId
        self.customerFullnameLabel.text = profile.fullName
        self.customerBirthDayLabel.text = profile.birthDay
        self.customerGenderLabel.text = profile.gender
        self.customerAgeLabel.text = "\(profile.age)"
        
        loadAssessment()
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.saveAssessmentToLocal()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func loadAssessment()
    {
        let vm = caseResultViewModel()
        if let od = vm.loadOnboard() {
            self.takeOffTextField.text = od.depTakeoff
            self.takeOffText2Field.text = od.arriveTakeoff
            self.fromAirportTextField.text = od.depFromAirport
            self.fromAirportText2Field.text = od.arriveFromAirport
            self.landingTextField.text = od.depLanding
            self.landingText2Field.text = od.arriveLanding
            self.toAirportTextField.text = od.deptoAirport
            self.toAirportText2Field.text = od.arriveToAirport
            self.ambulancePickupTextField.text = od.depAmbulancePickup
            self.ambulancePickupText2Field.text = od.arriveAmbulancePickup
            self.ArrivalAtHosTextField.text = od.depArriveHospital
            self.handOverAtText2Field.text = od.arriveHandover
            self.leavingFromHosTextField.text = od.depLeaveHospital
            self.timeText2Field.text = od.arriveTime
            self.givedByTextField.text = od.depGiveBy
            self.givedByText2Field.text = od.arriveGiveBy
            self.recievedByTextField.text = od.depRecieveBy
            self.recievedByText2Field.text = od.arriveRecieveBy
            
            od.recieveItems
                .filter { $0.recieveItemSend }
                .forEach { [weak self] item in
                    self?.tranferItemButton
                        .filter { $0.tag == item.id }
                        .forEach {
                            $0.isChecked = true
                            $0.setImage(#imageLiteral(resourceName: "checked"), for: .normal) } }
            
            od.recieveItems
                .filter { !$0.recieveItemSend }
                .forEach { [weak self] item in
                    self?.recieveItemButton
                        .filter { $0.tag == item.id }
                        .forEach {
                            $0.isChecked = true
                            $0.setImage(#imageLiteral(resourceName: "checked"), for: .normal) } }
        }
    }
    
    @IBAction func textFieldEditing(_ sender: TextField) {
        let mode = UIDatePickerMode.time
        let dateFomatter = DateFormatter()
        dateFomatter.locale = Locale(identifier: "en_US")
        dateFomatter.dateFormat = "HH:mm"
        let picker = ActionSheetDatePicker(title: "Select Time", datePickerMode: mode, selectedDate: Date(), doneBlock: { (picker, value, index) in
            
            let value = dateFomatter.string(from: value as! Date)
            //departure
            if sender == self.takeOffTextField {
                self.takeOffTextField.text = value
            }else if sender == self.landingTextField {
                self.landingTextField.text = value
            }else if sender == self.ambulancePickupTextField {
                self.ambulancePickupTextField.text = value
            }else if sender == self.leavingFromHosTextField {
                self.leavingFromHosTextField.text = value
            }else if sender == self.ArrivalAtHosTextField {
                self.ArrivalAtHosTextField.text = value
            }
            
            //arrival
            if sender == self.takeOffText2Field {
                self.takeOffText2Field.text = value
            }else if sender == self.landingText2Field {
                self.landingText2Field.text = value
            }else if sender == self.ambulancePickupText2Field {
                self.ambulancePickupText2Field.text = value
            }else if sender == self.timeText2Field {
                self.timeText2Field.text = value
            }
            
            sender.resignFirstResponder()
            }, cancel: nil, origin: sender)
        picker?.locale = Locale(identifier: "th_TH")
        picker?.show()
        sender.inputView = UIView()
    }
}

extension AssessmentViewController {
    
    @IBAction func closeView(sender: AnyObject) {
        self.saveAssessmentToLocal()

        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveAllAssessment(sender: AnyObject) {
        self.saveAssessmentToLocal()

        let alert = UIAlertController(title: "Save Success", message: "Onboard Assessment has been save.", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (alert) in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func recieveItemClick(sender: AnyObject) {
        guard let button = recieveItemButton.first(where: { $0.tag == sender.tag }) else
        {
            return
        }
        
        if button.isChecked {
            button.setImage(UIImage(named: "unchecked"), for: UIControlState.normal)
            button.isChecked = false
        }else{
            button.setImage(UIImage(named: "checked"), for: UIControlState.normal)
            button.isChecked = true
        }
    }
    
    @IBAction func tranferItemClick(sender: AnyObject) {
        guard let button = tranferItemButton.first(where: { $0.tag == sender.tag }) else
        {
            return
        }
        
        if button.isChecked {
            button.setImage(#imageLiteral(resourceName: "unchecked"), for: UIControlState.normal)
            button.isChecked = false
        }else{
            button.setImage(#imageLiteral(resourceName: "checked"), for: UIControlState.normal)
            button.isChecked = true
        }
    }
    
    
    
    func saveAssessmentToLocal(){
        let flightInfo = FlightInfoResult()
        var items = [RecieveItemResult]()
        
        recieveItemButton
            .filter { $0.isChecked }
            .forEach {
                let item = RecieveItemResult()
                item.id = $0.tag
                item.recieveItemSend = false
                items.append(item) }
        
        tranferItemButton
            .filter { $0.isChecked }
            .forEach {
                let item = RecieveItemResult()
                item.id = $0.tag
                item.recieveItemSend = true
                items.append(item) }
        
        flightInfo.depTakeoff = takeOffTextField.text!
        flightInfo.depFromAirport = fromAirportTextField.text!
        flightInfo.depLanding = landingTextField.text!
        flightInfo.deptoAirport = toAirportTextField.text!
        flightInfo.depAmbulancePickup = ambulancePickupTextField.text!
        flightInfo.depArriveHospital = ArrivalAtHosTextField.text!
        flightInfo.depLeaveHospital = leavingFromHosTextField.text!
        flightInfo.depGiveBy = givedByTextField.text!
        flightInfo.depRecieveBy = recievedByTextField.text!
        
        flightInfo.arriveTakeoff = takeOffText2Field.text!
        flightInfo.arriveFromAirport = fromAirportText2Field.text!
        flightInfo.arriveLanding = landingText2Field.text!
        flightInfo.arriveToAirport = toAirportText2Field.text!
        flightInfo.arriveAmbulancePickup = ambulancePickupText2Field.text!
        flightInfo.arriveHandover = handOverAtText2Field.text!
        flightInfo.arriveTime = timeText2Field.text!
        flightInfo.arriveGiveBy = givedByText2Field.text!
        flightInfo.arriveRecieveBy = recievedByText2Field.text!
        
        flightInfo.recieveItems = items
        
        let vm = caseResultViewModel()
        vm.saveOnboard(data: flightInfo,state: "FlightInfo")
    }
}
