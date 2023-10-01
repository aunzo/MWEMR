import UIKit
import Material
import RxSwift

class MedicalBagViewController: UIViewController {

    typealias LoadBagCallback = ()->Void
    typealias NotLoadBagCallback = ()->Void
    var isLoadBagCallback: LoadBagCallback?
    var isNotLoadBagCallback: NotLoadBagCallback?
    var viewModel = MedicalBagViewModel()
    let bag = DisposeBag()
    @IBOutlet weak var bagTableView: UITableView!
    @IBOutlet weak var noDatalabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.change.subscribe(onCompleted: {
            if self.viewModel.numberOfItems() == 0 {
                self.noDatalabel.isHidden = false
            }else{
                self.noDatalabel.isHidden = true
            }
            self.bagTableView.reloadData()
            
        }).disposed(by: bag)
        
        self.viewModel.load(view: self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MedicalBagViewController {
    @IBAction func closeView(sender: AnyObject) {
        self.isNotLoadBagCallback!()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func loadData(sender:UIButton){
        let alert = UIAlertController(title: "Confirm", message: "Do You want to download this bag?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (alert) in
            
        }))
        
        alert.addAction(UIAlertAction(title: "Download", style: UIAlertAction.Style.default, handler: { (alert) in
            self.viewModel.downloadToLocal(index: sender.tag)
            self.viewModel.loadDetailBag(view: self.view, index: sender.tag).subscribe(onCompleted: { 
                let alert = UIAlertController(title: "Success", message: "Bag is already download.\n You want to open this bag?", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler: { (alert) in
                    self.isNotLoadBagCallback!()
                    self.dismiss(animated: true) {
                        
                    }
                }))
                
                alert.addAction(UIAlertAction(title: "Open", style: UIAlertAction.Style.default, handler: { (alert) in
                    self.dismiss(animated: true) {
                        self.isLoadBagCallback!()
                    }
                }))
                
                self.present(alert, animated: true, completion: nil)
                }).disposed(by: self.bag)
            self.bagTableView.reloadData()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func seeDetailBag(sender:UIButton){
        self.performSegue(withIdentifier: "bagDetail", sender: nil)
    }
    
}

extension MedicalBagViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bagCell") as! MedicalBagTableViewCell
        cell.contentCutomerView.layer.cornerRadius = 5
        cell.contentCutomerView.layer.shadowColor = UIColor.black.cgColor
        cell.contentCutomerView.layer.shadowOffset = CGSize(width:1.0, height:1.0)
        cell.contentCutomerView.layer.shadowOpacity = 0.5
        cell.contentCutomerView.layer.shadowRadius = 1.5
        
        cell.configure(item: self.viewModel.itemAt(index: indexPath.row))
        
        if self.viewModel.itemIsDownloaded(index: indexPath.row) {
            cell.downloadButton.setImage(UIImage(named: "see_detail"), for: UIControl.State.normal)
            cell.downloadButton.removeTarget(self, action: #selector(MedicalBagViewController.loadData(sender:)), for: UIControl.Event.touchUpInside)
            cell.downloadButton.addTarget(self, action: #selector(MedicalBagViewController.seeDetailBag(sender:)), for: UIControl.Event.touchUpInside)
        }else{
            cell.downloadButton.setImage(UIImage(named: "download"), for: UIControl.State.normal)
            cell.downloadButton.tag = indexPath.row
            cell.downloadButton.removeTarget(self, action: #selector(MedicalBagViewController.seeDetailBag(sender:)), for: UIControl.Event.touchUpInside)
            cell.downloadButton.addTarget(self, action: #selector(MedicalBagViewController.loadData(sender:)), for: UIControl.Event.touchUpInside)
        }
        
        
        return cell
    }
}

extension  MedicalBagViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
