import UIKit
import Material
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var usernameTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var loginButton: RaisedButton!
    
    let viewModel = UserViewModel()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.layer.cornerRadius = 5
        loginView.layer.shadowColor = UIColor.black.cgColor
        loginView.layer.shadowOffset = CGSize(width:1.0,height:1.0)
        loginView.layer.shadowOpacity = 0.5
        loginView.layer.shadowPath = UIBezierPath(rect: loginView.bounds).cgPath
        
        
        self.usernameTextField.rx.textInput.text.subscribe(onNext: { (text) in
            self.loginButton.setTitle("Login", for: UIControlState.normal)
            self.loginButton.backgroundColor = UIColor(hexString: "#21529D")
        }).disposed(by: bag)
        
        self.passwordTextField.rx.textInput.text.subscribe(onNext: { (text) in
            self.loginButton.setTitle("Login", for: UIControlState.normal)
            self.loginButton.backgroundColor = UIColor(hexString: "#21529D")
        }).disposed(by: bag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        self.view.endEditing(true)
    }

    @IBAction func loginClick(sender: AnyObject) {
        self.dismissKeyboard(sender: sender)
        if usernameTextField.text != "" && passwordTextField.text != "" {
            if self.viewModel.login(username: usernameTextField.text!, password: passwordTextField.text!) {
                self.usernameTextField.text = ""
                self.passwordTextField.text = ""
                self.performSegue(withIdentifier: "finishLogin", sender: nil)
            }else{
                self.loginButton.setTitle("Username or Password incorrect.", for: UIControlState.normal)
                self.loginButton.backgroundColor = Material.Color.red.accent3
            }
        }else{
            self.loginButton.setTitle("Please input username and password.", for: UIControlState.normal)
            self.loginButton.backgroundColor = Material.Color.red.accent3
        }
    }
}
