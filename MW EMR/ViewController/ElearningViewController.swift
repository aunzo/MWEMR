import UIKit
import Material
import RxSwift
import MWPhotoBrowser

class ElearningViewController: UIViewController {

    @IBOutlet weak var elearningTableView: UITableView!
    
    var viewModel = ElearningViewModel()
    var hud2:MBProgressHUD?
    @IBOutlet weak var noDatalabel: UILabel!
    
    let bag = DisposeBag()
    var photos:[MWPhoto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.change.subscribe(onCompleted: {
            if self.viewModel.numberOfItems() == 0 {
                self.noDatalabel.isHidden = false
            }else{
                self.noDatalabel.isHidden = true
            }
            self.elearningTableView.reloadData()
            
        }).disposed(by: bag)
        
        self.viewModel.load(view: self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ElearningViewController {
    @IBAction func closeView(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func cancelDownloadPDF(){
        self.viewModel.cancelDownload()
    }
    
    @objc func loadData(sender:UIButton){
        let alert = UIAlertController(title: "Confirm", message: "Do You want to download this elearning?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (alert) in
        }))
        
        alert.addAction(UIAlertAction(title: "Download", style: UIAlertAction.Style.default, handler: { (alert) in
            self.hud2 = MBProgressHUD.showAdded(to: self.view, animated: true)
            
            self.hud2!.mode = MBProgressHUDMode.determinate
            self.hud2!.labelText = "Downloading"
            self.hud2!.show(true)
//            self.hud2!.button.setTitle("Cancel", for: UIControl.State.normal)
//            self.hud2!.button.addTarget(self, action: #selector(ElearningViewController.cancelDownloadPDF), for: UIControl.Event.touchUpInside)
            self.viewModel.downloadToLocal(index: sender.tag).subscribe(onNext: { (progress) in
                self.hud2!.progress = progress
                    if progress == 1 {
                        self.elearningTableView.reloadData()
                        self.hud2?.hide(true)
                    }
                }).disposed(by: self.bag)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func deleteFile(sender:UIButton) {
        let alert = UIAlertController(title: "Confirm", message: "Do You want to delete this elearning?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (alert) in
        }))
        
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { (alert) in
            self.viewModel.removePdf(index: sender.tag).subscribe(onNext: {
                self.elearningTableView.reloadData()
                }, onError: { (error) in
                    
            }).disposed(by: self.bag)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @objc func openPDFFile(sender:UIButton) {
        if self.viewModel.itemIsDownloaded(index: sender.tag) {
            if self.viewModel.getTypeOfFile(index: sender.tag) == .pdf {
                let doc = self.viewModel.openElearningFile(index: sender.tag)
                let readerView = ReaderViewController(readerDocument: doc)
                readerView?.delegate = self
                
                readerView?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                readerView?.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                self.present(readerView!, animated: true, completion: { () -> Void in
                    
                })
            }else{
                photos = []
                let photo = MWPhoto(image: self.viewModel.openImageFile(index: sender.tag))
                photo?.caption = self.viewModel.getImageName(index: sender.tag)
                photos.append(photo!)
                
                
                let browser = MWPhotoBrowser(delegate: self)
                // Set options
                browser?.displayActionButton = true
                browser?.displayNavArrows = true
                browser?.displaySelectionButtons = false
                browser?.zoomPhotosToFill = false
                browser?.alwaysShowControls = false
                browser?.enableGrid = false
                browser?.startOnGrid = false
                browser?.autoPlayOnAppear = true
                browser?.enableSwipeToDismiss = true
                browser?.setCurrentPhotoIndex(0)
                // Modal
                let nc = UINavigationController(rootViewController: browser!)
                nc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.present(nc, animated: true, completion: nil)
            }
        }
    }
    
}

extension ElearningViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "elearningCell") as! ElearningTableViewCell
        cell.contentCustomView.layer.cornerRadius = 5
        cell.contentCustomView.layer.shadowColor = UIColor.black.cgColor
        cell.contentCustomView.layer.shadowOffset = CGSize(width:1.0,height:1.0)
        cell.contentCustomView.layer.shadowOpacity = 0.5
        cell.contentCustomView.layer.shadowRadius = 1.5
        
        cell.configure(item: self.viewModel.itemAt(index: indexPath.row))
        
        if self.viewModel.itemIsDownloaded(index: indexPath.row) {
            cell.viewPdfButton.isEnabled = true
            cell.downloadFileButton.setImage(UIImage(named: "delete"), for: UIControl.State.normal)
            cell.viewPdfButton.backgroundColor = UIColor(hexString: "#21529D")
            cell.downloadFileButton.backgroundColor = Material.Color.red.accent3
            cell.downloadFileButton.removeTarget(self, action: #selector(ElearningViewController.loadData(sender:)), for: UIControl.Event.touchUpInside)
            cell.downloadFileButton.addTarget(self, action: #selector(ElearningViewController.deleteFile(sender:)), for: UIControl.Event.touchUpInside)
        }else{
            cell.viewPdfButton.isEnabled = false
            cell.viewPdfButton.backgroundColor = Material.Color.grey.lighten1
            cell.downloadFileButton.backgroundColor = UIColor(hexString: "#21529D")
            cell.downloadFileButton.setImage(UIImage(named: "download"), for: UIControl.State.normal)
            cell.downloadFileButton.removeTarget(self, action: #selector(ElearningViewController.deleteFile(sender:)), for: UIControl.Event.touchUpInside)
            cell.downloadFileButton.addTarget(self, action: #selector(ElearningViewController.loadData(sender:)), for: UIControl.Event.touchUpInside)
        }
        cell.downloadFileButton.tag = indexPath.row
        cell.viewPdfButton.tag = indexPath.row
        cell.viewPdfButton.addTarget(self, action: #selector(ElearningViewController.openPDFFile(sender:)), for: UIControl.Event.touchUpInside)
        
        
        return cell
    }
}

extension  ElearningViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)

    }
}

extension ElearningViewController:ReaderViewControllerDelegate {
    func dismiss(_ viewController: ReaderViewController!) {
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
    }
}



extension ElearningViewController:MWPhotoBrowserDelegate {
    
    func numberOfPhotos(in photoBrowser: MWPhotoBrowser!) -> UInt {
        return UInt(self.photos.count)
    }
    
    func photoBrowser(_ photoBrowser: MWPhotoBrowser!, photoAt index: UInt) -> MWPhotoProtocol! {
        if (index < UInt(self.photos.count)) {
            return self.photos[Int(index)]
        }
        return nil;

    }
}
