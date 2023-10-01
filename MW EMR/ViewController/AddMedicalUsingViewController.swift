import UIKit
import RxSwift
import RxCocoa
import Material
import ActionSheetPicker_3_0
import SearchTextField

class AddMedicalUsingViewController: UIViewController {

    @IBOutlet weak var titleNavigationbar: UINavigationBar!
    @IBOutlet weak var actionButton: RaisedButton!
    
    @IBOutlet weak var searchItemTextField: SearchTextField!
    @IBOutlet weak var titleNavigationItem: UINavigationItem!
    @IBOutlet weak var amountTextField: TextField!
    @IBOutlet weak var noteTextField: TextField!
    @IBOutlet weak var typeNameLabel: UILabel!
    @IBOutlet weak var selectTypeSegment: UISegmentedControl!
    @IBOutlet weak var maxAmountLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    let viewModel = MedicalUsingViewModel()
    let bagViewModel = MedicalBagViewModel()
    
    let bag = DisposeBag()
    
    typealias AddCallback = ()->Void
    var finishAddCallback: AddCallback?
    var state = "add"
    var editItem = [String:String]()
    var itemMed:(id : [Int],barcode :[String], value : [String], type : [String], amount : [Int])?
    var itemMedSelect:(id : Int,barcode :String, value : String, type : String, amount : Int)?
    @IBOutlet weak var medicalLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSize(width:454,height: 325)
        
        
        if state == "edit" {
            self.medicalLabel.isHidden = false
            self.searchItemTextField.isHidden = true
            if editItem["typeMed"] != "Medication" {
                self.selectTypeSegment.selectedSegmentIndex = 1
                itemMed = bagViewModel.listNameItemWith(typeMed: "Equipment")
                self.amountTextField.isHidden = true
                self.maxAmountLabel.isHidden = true
            }else{
                itemMed = bagViewModel.listNameItemWith(typeMed: "Medication")
            }
        }else{
            self.medicalLabel.isHidden = true
            self.searchItemTextField.isHidden = false
            self.titleNavigationbar.topItem?.leftBarButtonItems = nil
            itemMed = bagViewModel.listNameItemWith(typeMed: "Medication")
            self.searchItemTextField.filterStrings(itemMed!.value)
        }
        
        if itemMed?.value.count == 0 {
            self.searchItemTextField.placeholder = "No medication available"
            self.searchItemTextField.isEnabled = false
            self.actionButton.isEnabled = false
        }else{
            self.searchItemTextField.placeholder = "Enter a medication"
            self.typeNameLabel.text = "-" //itemMed?.type[0]
            self.maxAmountLabel.text = ""//"(Max \(itemMed?.amount[0] ?? 0))"
            self.amountTextField.text = ""//"\(itemMed?.amount[0] ?? 0)"
            self.itemMedSelect = ((self.itemMed?.id[0])!,(self.itemMed?.barcode[0])!,(self.itemMed?.value[0])!,(self.itemMed?.type[0])!,(self.itemMed?.amount[0])!)
        }
        
        if state == "edit" {
            self.selectTypeSegment.isHidden = true
            self.titleLabel.text = "Edit Medication"
            self.medicalLabel.text = editItem["name"]
            self.typeNameLabel.text = editItem["type"]
            self.amountTextField.text = editItem["amount"]
            
            self.noteTextField.text = editItem["note"]
            self.actionButton.setTitle("Edit", for: UIControl.State.normal)
            self.itemMedSelect = (Int(editItem["itemId"]!)!,editItem["barcode"]!,editItem["name"]!,editItem["type"]!,Int(editItem["amount"]!)!)
            
            for (index,name) in (itemMed?.value)!.enumerated() {
                if name == editItem["name"] {
                    self.maxAmountLabel.text = "(Remain \(itemMed?.amount[index] ?? 0))"
                    self.itemMedSelect?.amount = itemMed?.amount[index] ?? 0
                }
            }
            
            self.amountTextField.rx.textInput.text.subscribe(onNext: { (text) in
                let newAmount = Int(text!) ?? 0
                let oldAmount = self.itemMedSelect?.amount ?? 0
                let maxAmount = Int(self.editItem["amount"] ?? "0")
                let sumAmount = maxAmount! - (newAmount - oldAmount)
                self.maxAmountLabel.text = "(Remain \(sumAmount))"
            }).disposed(by: bag)
        }
        
        viewModel.change.subscribe(onNext: { (action) in
            if action == .addOrUpdate {
                if self.state == "add" {
                    let alert = UIAlertController(title: "Add Success", message: "You want to add item more?", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: { (alert) in
                        self.dismiss(animated: true, completion: {
                            self.finishAddCallback!()
                        })
                    }))
                    
                    alert.addAction(UIAlertAction(title: "YES", style: UIAlertAction.Style.default, handler: { (alert) in
                        self.noteTextField.text = ""
                        self.typeNameLabel.text = "-"
                        self.maxAmountLabel.text = ""
                        self.amountTextField.text = ""
                        self.searchItemTextField.text = ""
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                }else{
                    let alertEdit = UIAlertController(title: "Edit Success", message: "item edited", preferredStyle: UIAlertController.Style.alert)
                    alertEdit.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: { (alert) in
                        self.dismiss(animated: true, completion: {
                            self.finishAddCallback!()
                        })
                    }))
                    
                    self.present(alertEdit, animated: true, completion: nil)
                }
            }
            }).disposed(by: bag)
        
        self.searchItemTextField.itemSelectionHandler = { item, itemPosition in
            self.searchItemTextField.text = item[itemPosition].title
            if let itemIndex = self.itemMed?.value.index(of: item[itemPosition].title) {
                self.typeNameLabel.text = self.itemMed?.type[itemIndex]
                if self.state == "edit" {
                    self.maxAmountLabel.text = "(Remain \(self.itemMed?.amount[itemIndex] ?? 0))"
                }else{
                    self.maxAmountLabel.text = "(Max \(self.itemMed?.amount[itemIndex] ?? 0))"
                }
                
                self.amountTextField.text = "\(self.itemMed?.amount[itemIndex] ?? 0)"
                
                self.itemMedSelect = ((self.itemMed?.id[itemIndex])!,(self.itemMed?.barcode[itemIndex])!,(self.itemMed?.value[itemIndex])!,(self.itemMed?.type[itemIndex])!,(self.itemMed?.amount[itemIndex])!)
            }
        }

    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.superview!.layer.cornerRadius  = 5
        self.view.superview!.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension AddMedicalUsingViewController {
    
    @IBAction func searchTextFieldChange(_ sender: AnyObject) {
        
        if self.searchItemTextField.text == "" {
            self.typeNameLabel.text = "-" //itemMed?.type[0]
            self.maxAmountLabel.text = ""//"(Max \(itemMed?.amount[0] ?? 0))"
            self.amountTextField.text = ""
        }
    }
    
    @IBAction func selectTypeUsing(sender: AnyObject) {
        if self.selectTypeSegment.selectedSegmentIndex == 0 {
            itemMed = bagViewModel.listNameItemWith(typeMed: "Medication")
            self.amountTextField.isHidden = false
            self.maxAmountLabel.isHidden = false
        }else{
            itemMed = bagViewModel.listNameItemWith(typeMed: "Equipment")
            self.amountTextField.isHidden = true
            self.maxAmountLabel.isHidden = true
        }
        
        self.searchItemTextField.text = ""
        self.typeNameLabel.text = "-" //itemMed?.type[0]
        self.maxAmountLabel.text = ""//"(Max \(itemMed?.amount[0] ?? 0))"
        self.amountTextField.text = ""
        self.noteTextField.text = ""
        
        if itemMed?.value.count == 0 {
            if self.selectTypeSegment.selectedSegmentIndex == 0 {
                self.searchItemTextField.placeholder = "No medication available"
            }else{
                self.searchItemTextField.placeholder = "No equipment available"
            }
            self.typeNameLabel.text = "-"
            self.amountTextField.text = "0"
            self.searchItemTextField.isEnabled = false
            self.actionButton.isEnabled = false
        }else{
            if self.selectTypeSegment.selectedSegmentIndex == 0 {
                self.searchItemTextField.placeholder = "Enter a medication"
            }else{
                self.searchItemTextField.placeholder = "Enter a equipment"
            }
            self.searchItemTextField.filterStrings(itemMed!.value)
            
            self.itemMedSelect = ((self.itemMed?.id[0])!,(self.itemMed?.barcode[0])!,(self.itemMed?.value[0])!,(self.itemMed?.type[0])!,(self.itemMed?.amount[0])!)

            
            self.searchItemTextField.isEnabled = true
            self.actionButton.isEnabled = true
        }
    }
    
    @IBAction func closeAddView(sender: AnyObject) {
        self.dismiss(animated: true, completion: {
            self.finishAddCallback!()
        })
    }
    @IBAction func addMedicalUsing(sender: AnyObject) {
        
        if (self.itemMed?.value.index(of: self.searchItemTextField.text!)) != nil || self.state == "edit" {
            
            
            let itemId = self.itemMedSelect?.id
            let name = self.itemMedSelect?.value
            let type = self.itemMedSelect?.type
            let typeMed = self.selectTypeSegment.selectedSegmentIndex == 0 ? "Medication" : "Equipment"
            let amount = Int(self.amountTextField.text!) ?? 0
            let note = self.noteTextField.text
            let remain = self.itemMedSelect?.amount
            let barcode = self.itemMedSelect?.barcode
            let lastAmount = Int(editItem["amount"] ?? "0")!
            
            if self.searchItemTextField.text != "" || self.state == "edit" {
                if amount != 0 || self.selectTypeSegment.selectedSegmentIndex == 1 {
                    if amount > (lastAmount + remain!) {
                        let alertEdit = UIAlertController(title: "Error", message: "Your can't add amount more than max amount.", preferredStyle: UIAlertController.Style.alert)
                        alertEdit.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: { (alert) in
                            
                        }))
                        
                        self.present(alertEdit, animated: true, completion: nil)
                    }else{
                        let item = ["id":Int(editItem["id"] ?? "0")!
                            ,"itemId":itemId!
                            ,"name":name!
                            ,"type":type!
                            ,"barcode":barcode!
                            ,"typeMed":typeMed
                            ,"amount": amount
                            ,"amountResult": Int(editItem["amount"] ?? "0")! - amount
                            ,"note":note!] as [String : Any]
                        viewModel.addOrUpdate(item: item,state: state)
                    }
                }else{
                    let alertEdit = UIAlertController(title: "Error", message: "Can't add without amount.", preferredStyle: UIAlertController.Style.alert)
                    alertEdit.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: { (alert) in
                        
                    }))
                    
                    self.present(alertEdit, animated: true, completion: nil)
                }
                
            }else{
                let alertEdit = UIAlertController(title: "Error", message: "Can't add without item.", preferredStyle: UIAlertController.Style.alert)
                alertEdit.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: { (alert) in
                    
                }))
                
                self.present(alertEdit, animated: true, completion: nil)
            }
        }else{
            let alertEdit = UIAlertController(title: "Error", message: "Please choose medication or equipment correct.", preferredStyle: UIAlertController.Style.alert)
            alertEdit.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: { (alert) in
                
            }))
            
            self.present(alertEdit, animated: true, completion: nil)
        }
    }
    
    @IBAction func deleteMedicalUsing(sender: AnyObject) {
        let alert = UIAlertController(title: "Remove", message: "You want to remove this item?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: { (alert) in
            
        }))
        
        alert.addAction(UIAlertAction(title: "Remove", style: UIAlertAction.Style.destructive, handler: { (alert) in
            self.viewModel.remove(id: self.editItem["id"]!)
            self.dismiss(animated: true, completion: {
                self.finishAddCallback!()
            })
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
}

extension AddMedicalUsingViewController: TextFieldDelegate {
    
    @objc(textField:shouldChangeCharactersInRange:replacementString:) func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField != self.searchItemTextField {
            let aSet =  CharacterSet(charactersIn:"0123456789").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            return string == numberFiltered
        }else{
            
            return true
        }
        
    }
}

extension AddMedicalUsingViewController: UITextFieldDelegate {

}
