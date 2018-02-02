import UIKit
import RxSwift
import RxCocoa


class ProgressionRecordViewController: UIViewController {
    
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
    
    let viewModel = ProgressionViewModel()
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
            self.listTableView.reloadData()
        }).disposed(by: bag)
        self.viewModel.load()
        
        let profile = CustomerSingleton.sharedInstance.customerProfile
        self.customerIDLabel.text = profile.personalId
        self.customerFullnameLabel.text = profile.fullName
        self.customerBirthDayLabel.text = profile.birthDay
        self.customerGenderLabel.text = profile.gender
        self.customerAgeLabel.text = "\(profile.age)"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let vm = caseResultViewModel()
        vm.saveProgessions()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! AddProgressionRecordViewController
        controller.finishAddCallback = { ()in
            self.viewModel.load()
        }
        
        if let item = sender as? [String:String] {
            controller.state = "edit"
            controller.editItem = item
        }
    }
}

extension ProgressionRecordViewController {
    @IBAction func backToMenu(sender: AnyObject) {
        let vm = caseResultViewModel()
        vm.saveProgessions()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addProgression(sender: AnyObject) {
        self.performSegue(withIdentifier: "addProgression", sender: nil)
    }
    
   
}

extension ProgressionRecordViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.viewModel.numberOfItems() == 0 {
            return 1
        }
        
        return self.viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! ProgressionTableViewCell
        cell.layoutMargins = UIEdgeInsets.zero
        
        if self.viewModel.numberOfItems() == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "emptyCell") as! ProgressionTableViewCell
        }else{
            let item = self.viewModel.listItem(index: indexPath.row)
            cell.timeLabel.text = item["time"]
            cell.cgsLabel.text = item["cgs"]
            cell.pupilLabel.text = item["pupil"]
            cell.btLabel.text = item["bt"]
            cell.prLabel.text = item["pr"]
            cell.rrLabel.text = item["rr"]
            cell.bpLabel.text = item["bp"]
            cell.spo2Label.text = item["spo2"]
            cell.etco2Label.text = item["etco2"]
            cell.ekgLabel.text = item["ekg"]
            cell.painScoreLabel.text = item["painScore"]
            cell.inputLabel.text = item["input"]
            cell.outputLabel.text = item["output"]
            cell.tmLabel.text = item["tm"]
            cell.remarkLabel.text = item["remark"]
        }
        
        return cell
    }
}

extension ProgressionRecordViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.viewModel.numberOfItems() != 0 {
            let item = self.viewModel.listItem(index: indexPath.row)
            self.performSegue(withIdentifier: "addProgression", sender: item)
        }
    }
}

