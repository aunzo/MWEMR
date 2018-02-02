import UIKit
import RxSwift
import RxCocoa

class MedicalUsingViewController: UIViewController {

    @IBOutlet weak var customerView: UIView!
    
    @IBOutlet weak var passportLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    
    //CustomerProfile
    @IBOutlet weak var customerIDLabel: UILabel!
    @IBOutlet weak var customerFullnameLabel: UILabel!
    @IBOutlet weak var customerBirthDayLabel: UILabel!
    @IBOutlet weak var customerGenderLabel: UILabel!
    @IBOutlet weak var customerAgeLabel: UILabel!
    
    let viewModel = MedicalUsingViewModel()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customerView.layer.cornerRadius = 5
        customerView.layer.shadowColor = UIColor.black.cgColor
        customerView.layer.shadowOffset = CGSize(width:1.0,height:1.0)
        customerView.layer.shadowOpacity = 0.5
        customerView.layer.shadowRadius = 1.5
        
        listTableView.tableFooterView = UIView()
        
        viewModel.change.subscribe(onNext: { (action) in
            if action == .list || action == .delete{
                self.listTableView.reloadData()
            }else if action == .addOrUpdate {
                self.listTableView.reloadData()
            }
        }).disposed(by: bag)
        
        self.viewModel.load()
        
        let profile = CustomerSingleton.sharedInstance.customerProfile
        self.customerIDLabel.text = profile.personalId
        self.customerFullnameLabel.text = profile.fullName
        self.customerBirthDayLabel.text = profile.birthDay
        self.customerGenderLabel.text = profile.gender
        self.customerAgeLabel.text = "\(profile.age)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! AddMedicalUsingViewController
        controller.finishAddCallback = { ()in
            self.viewModel.load()
        }
        
        if let item = sender as? [String:String] {
            controller.state = "edit"
            controller.editItem = item
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let vm = caseResultViewModel()
        vm.saveMedicalUsing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
}

extension MedicalUsingViewController {
    @IBAction func backToMenu(sender: AnyObject) {
        let vm = caseResultViewModel()
        vm.saveMedicalUsing()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addMedicalUsing(sender: AnyObject) {
        self.performSegue(withIdentifier: "addMedicalUsing", sender: nil)
    }
}

extension MedicalUsingViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.viewModel.numberOfItems() == 0 {
            return 1
        }
        
        return self.viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! MedicalUsingTableViewCell
        cell.layoutMargins = UIEdgeInsets.zero
        
        if self.viewModel.numberOfItems() == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "emptyCell") as! MedicalUsingTableViewCell
        }else{
            let item = self.viewModel.listItem(index: indexPath.row)
            cell.nameLabel.text = item["name"]
            cell.typeLabel.text = item["type"]
            cell.amountLabel.text = item["typeMed"] == "Medication" ? item["amount"] : ""
            cell.noteLabel.text = item["note"]
        }
        
        return cell
    }
}

extension MedicalUsingViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.viewModel.numberOfItems() != 0 {
            let item = self.viewModel.listItem(index: indexPath.row)
            self.performSegue(withIdentifier: "addMedicalUsing", sender: item)
        }
        
    }
}
