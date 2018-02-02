import UIKit
import RxSwift

class LoadingViewController: UIViewController {

    let masterDataViewModel = MasterDataViewModel()
    let userViewModel = UserViewModel()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.masterDataViewModel.load()
        self.masterDataViewModel.change.subscribe(onError: { (error) in
            if !self.masterDataViewModel.checkDataInLocal() {
                let alertEdit = UIAlertController(title: "Error", message: "No internet connection.\nPleace check your internet.", preferredStyle: UIAlertControllerStyle.alert)
                alertEdit.addAction(UIAlertAction(title: "Exit", style: UIAlertActionStyle.default, handler: { (alert) in
                    exit(0)
                }))
                
                self.present(alertEdit, animated: true, completion: nil)
            }else{
                self.performSegue(withIdentifier: "login", sender: nil)
            }
            
            }, onCompleted: {
                self.userViewModel.load()
                self.userViewModel.change.subscribe(onError: { (error) in
                    let alertEdit = UIAlertController(title: "Error", message: "No internet connection.\nPleace check your internet.", preferredStyle: UIAlertControllerStyle.alert)
                    alertEdit.addAction(UIAlertAction(title: "Exit", style: UIAlertActionStyle.default, handler: { (alert) in
                        exit(0)
                    }))
                    
                    self.present(alertEdit, animated: true, completion: nil)
                    }, onCompleted: {
                        self.performSegue(withIdentifier: "login", sender: nil)
                }).disposed(by: self.bag)
        }).disposed(by: bag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
