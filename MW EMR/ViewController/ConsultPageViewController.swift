import UIKit
import Material
import ObjectMapper

class ConsultPageViewController: UIPageViewController {
    
    var index = 0
    var currentPage = 0
    var countConsult = 0
    var consultAll = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profile = CustomerSingleton.sharedInstance.customerProfile
        if let datas = UserDefaults.standard.object(forKey: "\(profile.caseId)\(profile.customerId)") {
            if let data = datas as? [String:Any] ,let consult =  data["consult"] as? [Any] {
                consultAll = consult
                self.delegate = self
                self.dataSource = self
                
                if consultAll.count != 0 {
                    let startingViewController = self.viewControllerAtIndex(index: self.index)
                    let viewControllers = [startingViewController]
                    
                    self.setViewControllers(viewControllers, direction: UIPageViewController.NavigationDirection.forward, animated: false, completion: nil)
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        for subView in self.view.subviews {
            if subView is UIPageControl {
                let pageController = subView as! UIPageControl
                pageController.currentPageIndicatorTintColor = UIColor(hexString: "#21529D")
                pageController.pageIndicatorTintColor = Material.Color.grey.lighten3
            }
        }
        super.viewDidLayoutSubviews()
    }
}

extension ConsultPageViewController {

    func viewControllerAtIndex(index: Int) -> ConsultViewController {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "consultView") as! ConsultViewController
        if consultAll.count != 0 {
            controller.consultResult = Mapper<ConsultResult>().map(JSONObject: self.consultAll[index])
        }else{
            controller.consultResult = nil
        }
        
        return controller
    }
}

extension ConsultPageViewController:UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if consultAll.count == 1 {
            return nil
        }
        
        if self.index == consultAll.count - 1 {
            self.index = 0
        }else{
            self.index = index + 1
        }
        
        return self.viewControllerAtIndex(index: self.index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if consultAll.count == 1 {
            return nil
        }
        
        if index == 0 {
            self.index = consultAll.count - 1
        }else{
            self.index = index - 1
        }
        
        return self.viewControllerAtIndex(index: self.index)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        if consultAll.count == 1 {
            return 0
        }
        
        return consultAll.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return index
    }
    
}

