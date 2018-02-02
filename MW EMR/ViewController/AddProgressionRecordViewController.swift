import UIKit
import RxSwift
import RxCocoa
import ActionSheetPicker_3_0
import Material

class AddProgressionRecordViewController: UIViewController {
    
    let viewModel = ProgressionViewModel()
    let bag = DisposeBag()
    var state = "add"
    var editItem = [String:String]()
    @IBOutlet weak var actionButton: RaisedButton!
    @IBOutlet weak var titleNavigationbar: UINavigationBar!
    
    //CustomerProfile
    @IBOutlet weak var customerIDLabel: UILabel!
    @IBOutlet weak var customerFullnameLabel: UILabel!
    @IBOutlet weak var customerBirthDayLabel: UILabel!
    @IBOutlet weak var customerGenderLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var timeLabel: TextField!
    @IBOutlet weak var pupilLabel: TextField!
    @IBOutlet weak var prLabel: TextField!
    @IBOutlet weak var spo2Label: TextField!
    @IBOutlet weak var ekgLabel: TextField!
    @IBOutlet weak var inputLabel: TextField!
    @IBOutlet weak var tmLabel: TextField!
    @IBOutlet weak var cgsLabel: TextField!
    @IBOutlet weak var btLabel: TextField!
    @IBOutlet weak var rrLabel: TextField!
    @IBOutlet weak var etco2Label: TextField!
    @IBOutlet weak var painScoreLabel: TextField!
    @IBOutlet weak var outputLabel: TextField!
    @IBOutlet weak var remarkLabel: TextField!
    @IBOutlet weak var bpLabel: TextField!
    
    typealias AddCallback = ()->Void
    var finishAddCallback: AddCallback?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSize(width:540,height: 457)
        
        if state == "edit" {
            self.timeLabel.text = editItem["time"]
            self.pupilLabel.text = editItem["pupil"]
            self.prLabel.text = editItem["pr"]
            self.spo2Label.text = editItem["spo2"]
            self.ekgLabel.text = editItem["ekg"]
            self.inputLabel.text = editItem["input"]
            self.tmLabel.text = editItem["tm"]
            self.cgsLabel.text = editItem["cgs"]
            self.btLabel.text = editItem["bt"]
            self.rrLabel.text = editItem["rr"]
            self.bpLabel.text = editItem["bp"]
            self.etco2Label.text = editItem["etco2"]
            self.painScoreLabel.text = editItem["painScore"]
            self.outputLabel.text = editItem["output"]
            self.remarkLabel.text = editItem["remark"]
            
            self.actionButton.setTitle("Edit", for: UIControlState.normal)
            
            self.titleLabel.text = "Edit Progresion"
        }else{
            
            self.titleNavigationbar.topItem?.leftBarButtonItems = nil
        }
        
        self.viewModel.change
            .subscribe(onNext: { () in
                let alert = UIAlertController(title: "Add Success", message: "You want to add item more?", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: { (alert) in
                    self.dismiss(animated: true, completion: {
                        self.finishAddCallback!()
                    })
                }))
                
                alert.addAction(UIAlertAction(title: "YES", style: UIAlertActionStyle.default, handler: { (alert) in
                    self.timeLabel.text = ""
                    self.pupilLabel.text = ""
                    self.prLabel.text = ""
                    self.spo2Label.text = ""
                    self.ekgLabel.text = ""
                    self.inputLabel.text = ""
                    self.tmLabel.text = ""
                    self.cgsLabel.text = ""
                    self.btLabel.text = ""
                    self.rrLabel.text = ""
                    self.bpLabel.text = ""
                    self.etco2Label.text = ""
                    self.painScoreLabel.text = ""
                    self.outputLabel.text = ""
                    self.remarkLabel.text = ""
                }))
                
                self.present(alert, animated: true, completion: nil)
                
                }, onCompleted: {
                    if self.state == "edit" {
                        let alertEdit = UIAlertController(title: "Edit Success", message: "item edited", preferredStyle: UIAlertControllerStyle.alert)
                        alertEdit.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (alert) in
                            self.dismiss(animated: true, completion: {
                                self.finishAddCallback!()
                            })
                        }))
                        
                        self.present(alertEdit, animated: true, completion: nil)
                    }else{
                        let alertError = UIAlertController(title: "Add Fail", message: "You've added this item already", preferredStyle: UIAlertControllerStyle.alert)
                        alertError.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (alert) in
                            
                        }))
                        
                        self.present(alertError, animated: true, completion: nil)
                    }
            }).disposed(by: bag)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.superview!.layer.cornerRadius  = 5
        self.view.superview!.layer.masksToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension AddProgressionRecordViewController {
    
    @IBAction func closeAddView(sender: AnyObject) {
        self.dismiss(animated: true, completion: {
            self.finishAddCallback!()
        })
    }
    @IBAction func addProgression(sender: AnyObject) {
        let time = self.timeLabel.text!
        let pupil = self.pupilLabel.text!
        let pr = self.prLabel.text!
        let spo2 = self.spo2Label.text!
        let ekg = self.ekgLabel.text!
        let input = self.inputLabel.text!
        let tm = self.tmLabel.text!
        let cgs = self.cgsLabel.text!
        let bt = self.btLabel.text!
        let rr = self.rrLabel.text!
        let bp = self.bpLabel.text!
        let etco2 = self.etco2Label.text!
        let painScore = self.painScoreLabel.text!
        let output = self.outputLabel.text!
        let remark = self.remarkLabel.text!
        
        if time != "" && (pupil != "" || pr != "" || spo2 != "" || ekg != "" || input != "" || tm != "" || cgs != "" || bt != "" || rr != "" || etco2 != "" || painScore != "" || output != "" || remark != "" || bp != "") {
            if state == "add" {
                viewModel.add(item: ["time":time,"cgs":cgs,"pupil":pupil,"bt":bt,"pr":pr,"rr":rr,"spo2":spo2,"etco2":etco2,"ekg":ekg,"painScore":painScore,"input":input,"output":output,"tm":tm,"remark":remark,"bp":bp])
            }else{
                viewModel.update(item: ["id":self.editItem["id"]!,"time":time,"cgs":cgs,"pupil":pupil,"bt":bt,"pr":pr,"rr":rr,"spo2":spo2,"etco2":etco2,"ekg":ekg,"painScore":painScore,"input":input,"output":output,"tm":tm,"remark":remark,"bp":bp])
            }
        }else{
            let alert = UIAlertController(title: "Error", message: "Please input time and less than one field.", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (alert) in
                
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func deleteProgression(sender: AnyObject) {
        let alert = UIAlertController(title: "Remove", message: "You want to remove this item?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: { (alert) in
            
        }))
        
        alert.addAction(UIAlertAction(title: "Remove", style: UIAlertActionStyle.destructive, handler: { (alert) in
            self.viewModel.remove(id: self.editItem["id"]!)
            self.dismiss(animated: true, completion: {
                self.finishAddCallback!()
            })
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func textFieldEditing(sender: TextField) {
        let mode = UIDatePickerMode.time
        let dateFomatter = DateFormatter()
        dateFomatter.locale = Locale(identifier: "en_US")
        dateFomatter.dateFormat = "HH:mm"
        let picker = ActionSheetDatePicker(title: "Select Time", datePickerMode: mode, selectedDate: Date(), doneBlock: { (picker, value, index) in
            
            let value = dateFomatter.string(from: value as! Date)
            self.timeLabel.text = value
            }, cancel: nil, origin: sender)
        picker?.locale = Locale(identifier: "th_TH")
        picker?.show()
        sender.inputView = UIView()
    }
}
