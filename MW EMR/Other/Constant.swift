import UIKit
import SystemConfiguration

struct Constant {
    static let testUrl = "http://localhost:8882"
    static let mainUrl = "http://mwemr.azurewebsites.net/WSDownLoad/"
    static let customerUrl = Constant.testUrl + "/customer"
    static let masterDataUrl = Constant.mainUrl + "LoadMasterData"
    static let userUrl = Constant.mainUrl + "LoadAuthen"
    static let allCaseUrl = Constant.mainUrl + "LoadCaseDataList"
    static let caseDetailUrl = Constant.mainUrl + "LoadCaseDetail"
    static let elearningUrl = Constant.mainUrl + "LoadElearningFileList"
    static let allBagUrl = Constant.mainUrl + "LoadListBag"
    static let bagDetailUrl = Constant.mainUrl + "LoadBagByBagId"
    static let uploadCase = Constant.mainUrl + "UploadCaseData"
    static let uploadBag = Constant.mainUrl + "UploadBag"
    static let uploadReport = Constant.mainUrl + "UploadReportFile"
    static let changePassportID = Constant.mainUrl + "UpdatePassport"
    
//    http://mwemr.azurewebsites.net/WSDownLoad/LoadMasterData
//    http://testemr.azurewebsites.net/wSDownLoad/UploadBag/?bagId=1
//    All Case :
//    http://testemr.azurewebsites.net/WSDownLoad/LoadCaseDataList
//    
//    Case Detail  :
//    http://testemr.azurewebsites.net/WSDownLoad/LoadCaseDetail?caseId=1
//    
//    Elearning :
//    http://testemr.azurewebsites.net/WSDownLoad/LoadElearningFileList
//    
//    All Bag :
//    http://testemr.azurewebsites.net/WSDownLoad/LoadListBag
//    
//    Bag Detail :
//    http://testemr.azurewebsites.net/WSDownLoad/LoadBagByBagId?bagId=1
}

enum DataAction {
    case addOrUpdate
    case list
    case delete
}

enum ResultStatus {
    case Success
    case Failture
    case noConsult
}

extension Notification.Name {
    static let saveDataNotification = Notification.Name("saveDataNotification")
    static let loadDataNotification = Notification.Name("loadDataNotification")
}


public class Reachability {
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}
