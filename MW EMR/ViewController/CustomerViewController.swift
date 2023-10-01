import UIKit
import Material
import RxSwift
import ObjectMapper
import MBProgressHUD

class CustomerViewController: UIViewController {
    
    typealias LoadCaseCallback = ()->Void
    var isLoadCaseCallback: LoadCaseCallback?
    var selectedMenu = 0
    var viewModel = CustomerViewModel()
    let bag = DisposeBag()
    var hud2:MBProgressHUD?
    var lastDownloadCustomerIndex = -1
    
    @IBOutlet weak var noDatalabel: UILabel!
    @IBOutlet weak var customerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedMenu == 2 {
            self.customerTableView.allowsSelection = false
        }else{
            self.customerTableView.allowsSelection = true
        }
        self.viewModel.change.subscribe(onNext: { (status) in
            if status == .Success
            {
                if self.viewModel.numberOfItems() == 0 {
                    self.noDatalabel.isHidden = false
                }else{
                    self.noDatalabel.isHidden = true
                }
                self.customerTableView.reloadData()
            }
            else if status == .noConsult
            {
                let alertEdit = UIAlertController(title: "Error", message: "This case can't get consult.\nPlease download agian or cancel.", preferredStyle: UIAlertController.Style.alert)
                alertEdit
                    .addAction(
                        UIAlertAction(
                            title: "Download",
                            style: UIAlertAction.Style.default) { [unowned self] _ in
                                self.viewModel.selectedItemAt(index: self.lastDownloadCustomerIndex)
                                self.viewModel.downloadToLocal(index: self.lastDownloadCustomerIndex,view: self.view)
                                self.customerTableView.reloadData()
                    })
                
                alertEdit.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel))
                
                self.present(alertEdit, animated: true, completion: nil)
            }
            else
            {
                let alertEdit = UIAlertController(
                    title: "Error",
                    message: "Can't download this case.\nPlease check your internet.",
                    preferredStyle: UIAlertController.Style.alert)
                alertEdit.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default))
                
                self.present(alertEdit, animated: true, completion: nil)
            }
            }).disposed(by: bag)
        
        viewModel
            .downloadReport
            .subscribe(
                onNext: { (progress) in
                    if progress == 0 {
                        self.hud2 = MBProgressHUD.showAdded(to: self.view, animated: true)
                        
                        self.hud2!.mode = MBProgressHUDMode.determinate
                        self.hud2!.labelText = "Downloading"
                        self.hud2!.show(true)
//                        self.hud2!.button.button.setTitle("Cancel", for: UIControl.State.normal)
//                        self.hud2!.button.addTarget(self, action: #selector(ElearningViewController.cancelDownloadPDF), for: UIControl.Event.touchUpInside)
                    }
                    
                    if self.hud2 != nil {
                        self.hud2!.progress = progress
                    }
                    
                    if progress == 1 {
                        self.hud2?.hide(true)
                    }
            })
            .disposed(by: bag)
        
        if selectedMenu == 2 {
            self.viewModel.load(view: self.view)
        }else{
            self.viewModel.loadFromLocal()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! MasterTabbarViewController
        controller.selectedMenu = selectedMenu
    }

}

extension CustomerViewController {
    @IBAction func closeView(sender: AnyObject) {
        self.isLoadCaseCallback!()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func loadData(sender:UIButton){
        let alert = UIAlertController(title: "Confirm", message: "Do You want to download this case?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel))
        
        alert.addAction(UIAlertAction(title: "Download", style: UIAlertAction.Style.default) { [unowned self] _ in
            self.lastDownloadCustomerIndex = sender.tag
            self.viewModel.selectedItemAt(index: sender.tag)
            self.viewModel.downloadToLocal(index: sender.tag,view: self.view)
            self.customerTableView.reloadData()
        })
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func openConsult(sender:UIButton){
        self.viewModel.selectedItemAt(index: sender.tag)
        self.performSegue(withIdentifier: "onBoard", sender: nil)
    }
    
    func openConsultCellClick(index:Int){
        self.viewModel.selectedItemAt(index: index)
        self.performSegue(withIdentifier: "onBoard", sender: nil)
    }
    
    @objc func deleteCase(sender:UIButton){
        let alert = UIAlertController(title: "Confirm", message: "Do You want to delete this case?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (alert) in
        }))
        
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { (alert) in
            self.viewModel.deleteCase(index: sender.tag,isNotSend: true)
            self.customerTableView.reloadData()
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func editPassport(sender:UIButton){
        let alert = UIAlertController(title: "Change your ID / Passport", message: "Enter a text", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "ID / Passport"
            textField.text = self.viewModel.itemAt(index: sender.tag).passport
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
        }))
        
        alert.addAction(UIAlertAction(title: "Change", style: .default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            self.viewModel.setPassportAt(index: sender.tag, passport: textField.text!)
            self.customerTableView.reloadData()
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func sentCaseToServer(sender:UIButton){
        let alert = UIAlertController(title: "Confirm", message: "Do You want to Send this case?\n Case has been delete after send already.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (alert) in
        }))
        
        alert.addAction(UIAlertAction(title: "Send", style: UIAlertAction.Style.destructive, handler: { (alert) in
            self.viewModel.sendCaseToServer(index: sender.tag, view: self.view).subscribe(onError: { (error) in
                var errorMsg = ""
                
                if let error = error as? caseError
                {
                    switch error
                    {
                        case .notSend:
                            errorMsg = "Case isn't send to server."
                            break
                        case .requireField(let msg):
                            errorMsg = "Please input all require field." + msg
                            break
                        default:
                            break
                    }
                }
                else
                {
                    errorMsg = error.localizedDescription
                }
                

                let alert = UIAlertController(title: "Send Failure", message: errorMsg , preferredStyle: UIAlertController.Style.alert)

                alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: { (alert) in
                    self.customerTableView.reloadData()
                }))

                self.present(alert, animated: true, completion: nil)
                }, onCompleted: {
                    let alert = UIAlertController(title: "Send Success", message: "Case is already send.", preferredStyle: UIAlertController.Style.alert)

                    alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: { (alert) in
                        self.customerTableView.reloadData()
                    }))

                    self.present(alert, animated: true, completion: nil)
            }).disposed(by: self.bag)

        }))
        
        self.present(alert, animated: true, completion: nil)

        
    }
    
    func cancelDownloadPDF(){
        self.viewModel.cancelDownload()
    }
}

extension CustomerViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customerCell") as! CustomerTableViewCell
        cell.contentCutomerView.layer.cornerRadius = 5
        cell.contentCutomerView.layer.shadowColor = UIColor.black.cgColor
        cell.contentCutomerView.layer.shadowOffset = CGSize(width:1.0,height:1.0)
        cell.contentCutomerView.layer.shadowOpacity = 0.5
        
        cell.contentCutomerView.layer.shadowRadius = 1.5
        
        cell.configure(item: self.viewModel.itemAt(index: indexPath.row))
        cell.upDownButton.tag = indexPath.row
        cell.deleteCaseButton.tag = indexPath.row
        cell.closeCaseButton.tag = indexPath.row
        cell.editIDButton.tag = indexPath.row
        cell.editIDButton.isHidden = true

        if self.viewModel.itemIsDownloaded(index: indexPath.row) {
            cell.editIDButton.isHidden = false
            cell.upDownButton.setImage(UIImage(named: "edit"), for: UIControl.State.normal)
            cell.closeCaseButton.isEnabled = true
            cell.closeCaseButton.backgroundColor = UIColor(hexString: "#21529D")
            cell.upDownButton.removeTarget(self, action: #selector(CustomerViewController.loadData(sender:)), for: UIControl.Event.touchUpInside)
            cell.upDownButton.addTarget(self, action: #selector(CustomerViewController.openConsult(sender:)), for: UIControl.Event.touchUpInside)
            
            cell.deleteCaseButton.addTarget(self, action: #selector(CustomerViewController.deleteCase(sender:)), for: UIControl.Event.touchUpInside)
            cell.closeCaseButton.addTarget(self, action: #selector(CustomerViewController.sentCaseToServer(sender:)), for: UIControl.Event.touchUpInside)
            
            if selectedMenu == 2 {
                if self.viewModel.itemIsDelete(index: indexPath.row) {
                    cell.closedCaseLabel.isHidden = false
                    cell.closeCaseButton.isHidden = true
                }else{
                    cell.closedCaseLabel.isHidden = true
                    cell.closeCaseButton.isHidden = false
                }
               
                cell.deleteCaseButton.isHidden = false
            }else{
                cell.closedCaseLabel.isHidden = true
                cell.closeCaseButton.isHidden = true
                cell.deleteCaseButton.isHidden = true
            }
            
        }else{
            if self.viewModel.itemIsDelete(index: indexPath.row) {
                cell.closedCaseLabel.isHidden = false
                cell.closeCaseButton.isHidden = true
            }else{
                cell.closedCaseLabel.isHidden = true
                cell.closeCaseButton.isHidden = false
            }
            cell.upDownButton.setImage(UIImage(named: "download"), for: UIControl.State.normal)
            cell.closeCaseButton.isEnabled = false
            cell.closeCaseButton.backgroundColor = Material.Color.grey.lighten1
            cell.upDownButton.removeTarget(self, action: #selector(CustomerViewController.openConsult(sender:)), for: UIControl.Event.touchUpInside)
            cell.upDownButton.addTarget(self, action: #selector(CustomerViewController.loadData(sender:)), for: UIControl.Event.touchUpInside)
            cell.deleteCaseButton.isHidden = true
        }
        
        cell.deleteCaseButton.addTarget(self, action: #selector(CustomerViewController.deleteCase(sender:)), for: UIControl.Event.touchUpInside)
        
        cell.editIDButton.addTarget(self, action: #selector(CustomerViewController.editPassport(sender:)), for: UIControl.Event.touchUpInside)
        
        
        return cell
    }
}

extension  CustomerViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        if selectedMenu != 2 {
            self.openConsultCellClick(index: indexPath.row)
        }
    }
}

