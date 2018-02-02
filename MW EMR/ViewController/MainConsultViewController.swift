import UIKit

class MainConsultViewController: UIViewController {
    
    @IBOutlet weak var customerView: UIView!
    @IBOutlet weak var customerIDLabel: UILabel!
    @IBOutlet weak var customerFullnameLabel: UILabel!
    @IBOutlet weak var customerBirthDayLabel: UILabel!
    @IBOutlet weak var customerGenderLabel: UILabel!
    @IBOutlet weak var customerAgeLabel: UILabel!
    @IBOutlet weak var consultView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customerView.layer.cornerRadius = 5
        customerView.layer.shadowColor = UIColor.black.cgColor
        customerView.layer.shadowOffset = CGSize(width:1.0, height:1.0)
        customerView.layer.shadowOpacity = 0.5
        customerView.layer.shadowRadius = 1.5
        
        let profile = CustomerSingleton.sharedInstance.customerProfile
        self.customerIDLabel.text = profile.personalId
        self.customerFullnameLabel.text = profile.fullName
        self.customerBirthDayLabel.text = profile.birthDay
        self.customerGenderLabel.text = profile.gender
        self.customerAgeLabel.text = "\(profile.age)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func closeView(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
