import UIKit

class SummaryReportViewModel: PreFlightViewModel
{
    var selectIndex = 0
    private let customer = CustomerSingleton.sharedInstance.customerProfile
    
    func load()
    {
        summaryReportItems = realm.objects(SummaryReport.self).filter("caseId == \(customer.caseId)")
        summaryReportChange.onNext(.list)
    }
    
    private func reload()
    {
        summaryReportChange.onNext(.addOrUpdate)
        summaryReportChange.onNext(.list)
    }
    
    func add(item: SummaryReport)
    {
        realm.beginWrite()
        if let obj = realm.objects(SummaryReport.self).last
        {
            item.id = obj.id + 1
        }
        item.customerId = customer.customerId
        item.caseId = customer.caseId
        item.isUpload = true
        realm.add(item, update: false)
        
        try? realm.commitWrite()
        
        reload()
    }
    
    func update(item: SummaryReport)
    {
        realm.beginWrite()
        
        item.customerId = customer.customerId
        item.caseId = customer.caseId
        
        realm.create(SummaryReport.self, value: item, update: true)
        
        try? realm.commitWrite()
        
        reload()
    }
    
    func consultInit(item: SummaryReport)
    {
        item.customerId = customer.customerId
        item.caseId = customer.caseId
        
        realm.beginWrite()
        
        realm.add(item, update: false)
        
        try? realm.commitWrite()
        
        summaryReportChange.onNext(.list)
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
