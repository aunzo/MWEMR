import UIKit
import RxSwift

class BagDetailViewController: UIViewController {

    @IBOutlet weak var bagTableView: UITableView!
    @IBOutlet weak var changeTypeSegment: UISegmentedControl!
    @IBOutlet weak var medicationView: UIView!
    @IBOutlet weak var equipmentView: UIView!
    @IBOutlet weak var uploadBagButton: UIBarButtonItem!
    
    var viewModel = MedicalBagViewModel()
    let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.getDetailBag()
        
        let caseViewModel = CustomerViewModel()
        caseViewModel.loadFromLocal()
        if caseViewModel.numberOfItems() == 0 {
            self.uploadBagButton.isEnabled = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.bagTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func sentBagToServer(sender: AnyObject) {
        let caseViewModel = CustomerViewModel()
        caseViewModel.loadFromLocal()
        if caseViewModel.numberOfItems() == 0 {
            
            let alert = UIAlertController(title: "Confirm", message: "Do You want sent all item in bag?\nWhen you sent bag has been remove.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (alert) in
            }))
            
            alert.addAction(UIAlertAction(title: "Sent", style: UIAlertAction.Style.destructive, handler: { (alert) in
                self.viewModel.sendBagToServer(view: self.view).subscribe(onCompleted: {
                    self.dismiss(animated: true, completion: nil)
                }).disposed(by: self.bag)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }else{
            let alertEdit = UIAlertController(title: "Error", message: "Your can't remove bag. Please clear all case before.", preferredStyle: UIAlertController.Style.alert)
            alertEdit.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: { (alert) in
                
            }))
            
            self.present(alertEdit, animated: true, completion: nil)
        }
        
    }
}

extension BagDetailViewController {
    @IBAction func changeBagType(sender: AnyObject) {
        self.bagTableView.reloadData()
        if self.changeTypeSegment.selectedSegmentIndex == 0 {
            self.equipmentView.isHidden = true
        }else{
            self.equipmentView.isHidden = false
        }
    }
    
    @IBAction func closeView(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension BagDetailViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.changeTypeSegment.selectedSegmentIndex == 0 {
            return self.viewModel.numberOfMedicalMedications() == 0 ? 1 : self.viewModel.numberOfMedicalMedications()
        }else{
            return self.viewModel.numberOfMedicalEquipments() == 0 ? 1 : self.viewModel.numberOfMedicalEquipments()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (self.viewModel.numberOfMedicalMedications() == 0 && self.changeTypeSegment.selectedSegmentIndex == 0)||(self.viewModel.numberOfMedicalEquipments() == 0 && self.changeTypeSegment.selectedSegmentIndex == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "emptyCell") as! BagDetailTableViewCell
            return cell
        }else{
            
            if self.changeTypeSegment.selectedSegmentIndex == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! BagDetailTableViewCell
                cell.configureMedication(item: self.viewModel.itemOfMedication(index: indexPath.row))
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "equipCell") as! BagDetailTableViewCell
                cell.configureEquipment(item: self.viewModel.itemOfEquipment(index: indexPath.row))
                return cell
            }

            
        }
    }
}
