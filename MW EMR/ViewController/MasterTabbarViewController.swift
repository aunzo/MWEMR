import UIKit

class MasterTabbarViewController: UITabBarController {

    var selectedMenu = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch selectedMenu {
        case 3:
            self.selectedIndex = 0
            break
        case 4:
            self.selectedIndex = 1
            break
        case 5:
            self.selectedIndex = 2
            break
        case 6:
            self.selectedIndex = 3
            break
        case 7:
            self.selectedIndex = 4
            break
        case 8:
            self.selectedIndex = 5
            break
        default:
            break
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
