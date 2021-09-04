import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    let viewModel = MenuViewModel()
    var isLoadedBag = false
    var isLoadedCase = false
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadBagAndCase()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "listElearning" {
            
        }else if segue.identifier == "listBag" && !self.isLoadedBag {
            let controller = segue.destination as! MedicalBagViewController
            controller.isLoadBagCallback = { ()in
                self.loadBagAndCase()
                self.menuCollectionView.reloadData()
                self.performSegue(withIdentifier: "listBagDetail", sender: nil)
            }
            controller.isNotLoadBagCallback = { ()in
                self.loadBagAndCase()
                self.menuCollectionView.reloadData()
            }
        }else if segue.identifier == "listBagDetail" {
            
        }else{
            let controller = segue.destination as! CustomerViewController
            controller.selectedMenu = sender as! Int
            controller.isLoadCaseCallback = { () in
                self.loadBagAndCase()
                self.menuCollectionView.reloadData()
            }
        }
    }
    
    func loadBagAndCase() {
        let bagViewModel = MedicalBagViewModel()
        bagViewModel.loadFromLocal()
        if bagViewModel.numberOfItems() != 0 {
            self.isLoadedBag = true
        }else{
            self.isLoadedBag = false
        }
        
        let caseViewModel = CustomerViewModel()
        caseViewModel.loadFromLocal()
        if caseViewModel.numberOfItems() != 0 {
            self.isLoadedCase = true
        }else{
            self.isLoadedCase = false
        }
        
        self.menuCollectionView.reloadData()
    }
    
    
    @IBAction func logoutClick(sender: AnyObject) {
        let alert = UIAlertController(title: "Log out", message: "Do You want to log out?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (alert) in
        }))
        
        alert.addAction(UIAlertAction(title: "Log out", style: UIAlertActionStyle.destructive, handler: { (alert) in
            UserDefaults.standard.set(false, forKey: "isLogined")
            UserDefaults.standard.set(0, forKey: "userAuth")
            UserDefaults.standard.synchronize()
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    

}

extension MenuViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as! MenuCollectionViewCell
        cell.layer.masksToBounds = false
        cell.layer.cornerRadius = 5
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width:1.0,height:1.0)
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 1.5
        
        if !isLoadedBag {
            if indexPath.row > 1 && indexPath.row < 9 {
                cell.contentView.alpha = 0.5
            }
        }else{
            if indexPath.row > 1 && indexPath.row < 9 {
                cell.contentView.alpha = 1
            }
        }
        
        if !isLoadedCase {
            if indexPath.row > 2 && indexPath.row < 9 {
                cell.contentView.alpha = 0.5
            }
        }else{
            if indexPath.row > 2 && indexPath.row < 9 {
                cell.contentView.alpha = 1
            }
        }
        
        if !Reachability.isConnectedToNetwork() {
            if indexPath.row == 2 {
                cell.contentView.alpha = 0.5
            }
        }
        
        cell.iconImageView.image = UIImage(named: viewModel.geticonName(index: indexPath.row))
        cell.titleLabel.text = viewModel.getTitleMenu(index: indexPath.row)
        
        return cell
    }
}

extension MenuViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.performSegue(withIdentifier: "listElearning", sender: indexPath.row)
        }else if indexPath.row == 1 {
            if self.isLoadedBag {
                self.performSegue(withIdentifier: "listBagDetail", sender: indexPath.row)
            }else{
                self.performSegue(withIdentifier: "listBag", sender: indexPath.row)
            }
        }else if indexPath.row == 2 {
            if self.isLoadedBag {
                if Reachability.isConnectedToNetwork() {
                    self.performSegue(withIdentifier: "listCustomer", sender: indexPath.row)
                }
            }
        }else if indexPath.row > 1 {
            if self.isLoadedBag && self.isLoadedCase {
                self.performSegue(withIdentifier: "listCustomer", sender: indexPath.row)
            }
        }
        
    }
}
