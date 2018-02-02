import UIKit

class SummaryReportViewModel: PreFlightViewModel {
    var selectIndex = 0
    func load(){
        let customer = CustomerSingleton.sharedInstance.customerProfile
        let items = realm.objects(SummaryReport.self).filter("caseId == \(customer.caseId)")
        self.summaryReportItems = items
        self.summaryReportChange.onNext(.list)
    }
    
    func addOrUpdate(item:[String:Any]){
        var itemEdit = item
        let customer = CustomerSingleton.sharedInstance.customerProfile
        try! realm.write {
            if itemEdit["id"] == nil {
                let obj = realm.objects(SummaryReport.self).last
                let insertObj = SummaryReport()
                if obj != nil {
                    insertObj.id = (obj?.id)! + 1
                }
                insertObj.customerId = customer.customerId
                insertObj.caseId = customer.caseId
                insertObj.title = itemEdit["title"]! as! String
                insertObj.path = itemEdit["path"]! as! String
                insertObj.isUpload = true
                realm.add(insertObj, update: false)
            }else{
                realm.create(SummaryReport.self, value: itemEdit, update: true)
            }
        }
        
        self.summaryReportChange.onNext(.addOrUpdate)
        self.summaryReportChange.onNext(.list)
    }
    
    func consultInit(item:[String:Any]){
        var itemEdit = item
        let customer = CustomerSingleton.sharedInstance.customerProfile
        itemEdit["customerId"] = customer.customerId
        itemEdit["caseId"] = customer.caseId
        
        try! realm.write {
            if itemEdit["id"] == nil {
                let obj = realm.objects(SummaryReport.self).last
                let insertObj = SummaryReport()
                if obj != nil {
                    insertObj.id = (obj?.id)! + 1
                }
                insertObj.customerId = Int(itemEdit["customerId"]! as! String)!
                insertObj.caseId = Int(itemEdit["caseId"]! as! String)!
                insertObj.title = itemEdit["title"]! as! String
                insertObj.path = itemEdit["path"]! as! String
                
                realm.add(insertObj, update: false)
            }else{
                realm.create(SummaryReport.self, value: itemEdit, update: true)
            }
        }
        
        self.summaryReportChange.onNext(.list)
    }
    
    func remove(id:String){
        let itemFind = realm.objects(SummaryReport.self).filter("id == \(id)")
        let fileName = itemFind.first?.path
        
        do {
            let fileManager = FileManager.default
            let documentDirectoryURLs = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
            
            if let filePath = documentDirectoryURLs.first?.appendingPathComponent(fileName ?? "").path {
                try fileManager.removeItem(atPath: filePath)
            }
            try! realm.write {
                realm.delete(itemFind)
                self.summaryReportChange.onNext(.delete)
            }
        } catch let error as NSError {
            print("ERROR: \(error)")
            self.summaryReportChange.onNext(.list)
        }
        
    }
    
    func numberOfItems() -> Int {
        return self.summaryReportItems?.count ?? 0
    }
    
    func listItem(index:Int) -> [String:String] {
        let item : SummaryReport = self.summaryReportItems![index]
        let id = item.id 
        let title = item.title
        return ["id":"\(id)","title":title]
    }
    
    func getTitle(index:Int) -> String {
        let item : SummaryReport = self.summaryReportItems![index]
        let title = item.title 
        //        let date = item.date ?? ""
        return title
    }
    
    func fromLocal(index:Int) -> Bool {
        let item : SummaryReport = self.summaryReportItems![index]
        //        let date = item.date ?? ""
        return item.isUpload
    }
    
    func getIdReport(index:Int) -> Int {
        let item : SummaryReport = self.summaryReportItems![index]
        //        let date = item.date ?? ""
        return item.id
    }
    
    func setSelectIndex(index:Int) {
        self.selectIndex = index
    }
    
    func getTypeOfFile(index:Int) -> TypeFile {
        let item : SummaryReport = self.summaryReportItems![index]
        let typeFile = item.path.characters.split{$0 == "."}.map(String.init).last
        if typeFile == "pdf" {
            return .pdf
        }else{
            return .image
        }
    }
    
    func openPdfFile(index:Int) -> ReaderDocument? {
        let item : SummaryReport = self.summaryReportItems![index]
        let pathComponent = item.path
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let document = ReaderDocument(filePath: documentsPath.appendingPathComponent(pathComponent), password: nil)
        document?.setFileDescription(item.title)
        return document
    }
    
    func getImagePath(index:Int) -> String {
        let item : SummaryReport = self.summaryReportItems![index]
        let pathComponent = item.path
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString 
        return documentsPath.appendingPathComponent(pathComponent)
    }
    
    func getImageName(index:Int) -> String {
        let item : SummaryReport = self.summaryReportItems![index]
        return item.path
    }

}

enum TypeFile {
    case pdf
    case image
}
