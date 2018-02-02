//
//  ViewImageViewController.swift
//  MW EMR
//
//  Created by AunzNuBee on 7/13/2559 BE.
//  Copyright © 2559 AunzNuBee. All rights reserved.
//

import UIKit

class ViewImageViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var clickToEditLabel: UILabel!
    var urlImage = ""
    var isLocal = true
    var titleString = ""
    var idReport = 0
    typealias EditCallback = ()->Void
    var finishEditCallback: EditCallback?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = titleString
        self.preferredContentSize = CGSize(width:628, height:824)
        self.clickToEditLabel.isHidden = !isLocal
        
        scrollView.delegate = self
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.flashScrollIndicators()
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
        
        if urlImage != "" {
            self.imageView.image = UIImage(contentsOfFile: urlImage)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeView(sender: AnyObject) {
        self.dismiss(animated: true) { 
            
        }
    }

    @IBAction func changeFileDescription(sender: AnyObject) {
        print("5555")
        if isLocal {
            let alert = UIAlertController(title: "Input image description", message: "Enter a text", preferredStyle: .alert)
            alert.addTextField(configurationHandler: { (textField) -> Void in
                textField.placeholder = "Description"
                textField.text = self.titleString
            })
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            }))
            
            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) -> Void in
                let textField = alert.textFields![0] as UITextField
                let summaryViewModel = SummaryReportViewModel()
                self.titleLabel.text = textField.text!
                summaryViewModel.addOrUpdate(item: ["id":"\(self.idReport)","title":textField.text!])
                self.finishEditCallback!()
                
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {viewImageFile
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ViewImageViewController:UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}
