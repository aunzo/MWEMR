import UIKit
import RxSwift
import RxCocoa
import RealmSwift
import ObjectMapper
import Alamofire
import MBProgressHUD

class CustomerViewModel {
    private let connection = Connection()
    private let bag = DisposeBag()
    private var model:[Customer] = []
    private let realm = try! Realm()
    var change = PublishSubject<ResultStatus>()
    var downloadReport = PublishSubject<Float>()
    final private var tempModel:[[String:Any]] = []
    private var request: Alamofire.Request?
    private var reportFile = [SummaryReportResult]()
    func load(view:UIView){
        MBProgressHUD.showAdded(to: view, animated: true)
        connection.get(model: Customer(), path: Constant.allCaseUrl)
            .subscribe(onNext: { (model) in
                self.model = model
                self.tempModel = model.toJSON()
                let customer = try! Realm().objects(Customer.self).toArray(ofType: Customer.self)
                for cus in customer {
                    let localeCus = self.model.filter( { return ($0.caseId == cus.caseId && $0.customerId == cus.customerId) })
                    if localeCus.count == 0 {
                        self.model.append(cus)
                        let cusObj = Customer()
                        cusObj.caseId = cus.caseId
                        cusObj.customerId = cus.customerId
                        cusObj.age = cus.age
                        cusObj.birthDay = cus.birthDay
                        cusObj.personalId = cus.personalId
                        cusObj.fullName = cus.fullName
                        cusObj.gender = cus.gender
                        cusObj.isDelete = 1
                        self.tempModel.append(cusObj.toJSON())
                    }
                    else
                    {
                        self.model.first(where: { $0.customerId == cus.customerId} )?.personalId = cus.personalId
                    }
                }
                
                MBProgressHUD.hide(for: view, animated: true)
                self.change.onNext(.Success)
            }, onError: { (error) in
                self.model = try! Realm().objects(Customer.self).toArray(ofType: Customer.self)
                self.tempModel = self.model.toJSON()
                MBProgressHUD.hide(for: view, animated: true)
                self.change.onNext(.Success)
            }).disposed(by: bag)
    }
    
    func loadFromLocal(){
        self.model = realm.objects(Customer.self).toArray(ofType: Customer.self)
        self.change.onNext(.Success)
    }
    
    func numberOfItems() -> Int {
        return self.model.count
    }
    
    func itemAt(index:Int) -> (fullName:String,gender:String,age:Int,passport:String) {
        let item = self.model[index]
        return (item.fullName,item.gender,item.age,item.personalId)
    }
    
    func setPassportAt(index:Int,passport:String) {
        try! realm.write {
            self.model[index].personalId = passport
            let cus = realm.objects(Customer.self).filter("customerId == \(self.model[index].customerId)").first
            cus?.personalId = passport
            realm.add(cus!, update: .all)
        }
        
        let connect = Connection()
        connect.changePassportID(customerID: self.model[index].customerId, passport: passport).subscribe(onError: { (error) in
        }, onCompleted: {
        }).disposed(by: self.bag)
    }
    
    func itemIsDownloaded(index:Int) -> Bool {
        let cus = try! Realm().objects(Customer.self).toArray(ofType: Customer.self)
        if cus.contains(where: {$0.caseId == self.model[index].caseId}) {
            return true
        } else {
            return false
        }
    }
    
    func itemIsDelete(index:Int) -> Bool {
        if self.tempModel[index]["isDelete"] as! Int == 1 {
            return true
        }
        return false
    }
    
    func selectedItemAt(index:Int){
        if let obj = model.filter({$0.caseId == self.model[index].caseId}).first {
            CustomerSingleton.sharedInstance.SetCustomerProfile(profile: obj)
        }
    }
    
    func downloadToLocal(index:Int,view:UIView){
        reportFile = [SummaryReportResult]()
        MBProgressHUD.showAdded(to: view, animated: true)
        connection.getRawData(path: Constant.caseDetailUrl + "?caseId=\(self.model[index].caseId)")
            .subscribe(onNext: { (data) in
                print(data)
                let key = "\(self.model[index].caseId)\(self.model[index].customerId)"
                var consultRes = ConsultResult()
                if let obj = self.model.filter({$0.caseId == self.model[index].caseId}).first {
                    try! self.realm.write {
                        self.realm.add(obj,update: .all)
                    }
                }
                
                if let caseDetails = data as? [[String:Any]],  caseDetails.first != nil {
                    var datas = caseDetails.first!
                    guard let consult = datas["consult"] as? [Any], !consult.isEmpty else
                    {
                        self.deleteCase(index: index,isNotSend: false)
                        self.change.onNext(.noConsult)
                        return
                    }

                    datas["consult"] = consult
                    
                    guard let consultR = datas["consultResult"] as? [String:Any], let consultResult = Mapper<ConsultResult>().map(JSON:consultR) else
                    {
                        self.deleteCase(index: index,isNotSend: false)
                        self.change.onNext(.noConsult)
                        return
                    }
                    
                    datas["consultResult"] = consultResult.toJSON()
                    consultRes = consultResult
                    
                    UserDefaults.standard.set(datas, forKey: key)
                    UserDefaults.standard.synchronize()
                    
                    let caseVm = caseResultViewModel()
                    caseVm.initCaseResult(csr: consultRes,cs: datas)
                    
                    MBProgressHUD.hide(for: view, animated: true)
                    if let report = datas["reportFile"] as?[[String:AnyObject]] {
                        self.downloadReportFile(indexFile: 0,report: report)
                    }
                    self.change.onNext(.Success)
                }else{
                    self.change.onNext(.Failture)
                }
                
                }, onError: { (error) in
                    MBProgressHUD.hide(for: view, animated: true)
                    self.change.onNext(.Failture)
            }).disposed(by: bag)
        
    }
    
    func downloadReportFile(indexFile:Int,report:[[String:Any]]){
        let profile = CustomerSingleton.sharedInstance.customerProfile
        if report.count != 0 {
            if report.count > indexFile {
                if let reportFile = Mapper<SummaryReportResult>().map(JSON:report[indexFile]) {
                    self.downloadReport.onNext(0)
                    let typeFile = reportFile.path.split{$0 == "."}.map(String.init)
                    let title = reportFile.title.replacingOccurrences(of: " ", with: "")
                    let pathComponent = "\(profile.caseId)\(profile.customerId)\(reportFile.id)\(title).\(typeFile.last!)"
                    self.request = AF.download(reportFile.path, to: { (temporaryURL, response) -> (destinationURL: URL, options: DownloadRequest.Options) in
                        let fileManager = FileManager.default
                        let directoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
                        
                        
                        return (directoryURL.appendingPathComponent(pathComponent),[.removePreviousFile, .createIntermediateDirectories])
                    }).downloadProgress(closure: { (progress) in
                        DispatchQueue.main.async {
                            self.downloadReport.onNext(Float(progress.fractionCompleted))
                        }
                    }).response(completionHandler: { (response) in
                        let rep = SummaryReportResult()
                        rep.id = Int("\(profile.caseId)\(profile.customerId)\(reportFile.id)")!
                        rep.title = reportFile.title
                        rep.path = pathComponent
                        rep.isUpload = false
                        self.reportFile.append(rep)
                        
                        
                        if report.count - 1 == indexFile {
                            let caseVm = caseResultViewModel()
                            caseVm.saveReportFile(sumReport: self.reportFile)
                        }
                        
                        self.downloadReportFile(indexFile: indexFile + 1, report: report)
                        self.downloadReport.onNext(1)
                    })
                }else{
                    self.downloadReport.onNext(1)
                }
            }else{
                self.downloadReport.onNext(1)
            }
            
        }else{
            self.downloadReport.onNext(1)
        }
        
    }
    
    func cancelDownload(){
        self.request?.cancel()
    }
    
    func sendCaseToServer(index:Int,view:UIView)-> Observable<Void>{
        return Observable.create({ (observer) -> Disposable in
            MBProgressHUD.showAdded(to: view, animated: true)
            self.selectedItemAt(index: index)
            let vm = caseResultViewModel()
            let cr = vm.prepareCaseResult()
            
            if cr.caseDicgnosis != "" && cr.preflight.first?.brief != "" && cr.flightInfo.first?.depGiveBy != "" && cr.flightInfo.first?.arriveGiveBy != "" && cr.flightInfo.first?.depRecieveBy != "" && cr.flightInfo.first?.arriveRecieveBy != "" && cr.flightInfo.first?.painassessmentTypeId != 0 {
                let caseRes = Mapper().toJSON(cr)
                let connect = Connection()
                
                vm.uploadReport.subscribe(onNext: { (index) in
                    vm.uploadReportFile(index: index)
                }).disposed(by: self.bag)
                
                vm.uploadReport.subscribe(onCompleted: {
                    connect.changePassportID(customerID: self.model[index].customerId, passport: self.model[index].personalId).subscribe(onError: { (error) in
                        MBProgressHUD.hide(for: view, animated: true)
                        observer.onError(caseError.notSend)
                    }, onCompleted: {
                        connect.uploadCase(data: caseRes).subscribe(onError: { (error) in
                            MBProgressHUD.hide(for: view, animated: true)
                            observer.onError(caseError.notSend)
                        }, onCompleted: {
                            self.deleteCase(index: index,isNotSend: false)
                            MBProgressHUD.hide(for: view, animated: true)
                            observer.onCompleted()
                            self.load(view: view)
                        }).disposed(by: self.bag)
                    }).disposed(by: self.bag)
                }).disposed(by: self.bag)
                
                vm.uploadReport.subscribe( onError: { (error) in
                    observer.onError(caseError.requireField(message: "Can't upload report file"))
                    MBProgressHUD.hide(for: view, animated: true)
                }).disposed(by: self.bag)
                
                vm.uploadReportFile(index: 0)
                
                
            }else{
                MBProgressHUD.hide(for: view, animated: true)
                var require = ""
                if cr.caseDicgnosis == "" { require = require + "\n Dx in Capital Letter"}
                if cr.preflight.first?.brief == "" { require = require + "\n Brief History"}
                if cr.flightInfo.first?.depGiveBy == "" { require = require + "\n Department GiveBy"}
                if cr.flightInfo.first?.arriveGiveBy == "" { require = require + "\n Department RecieveBy"}
                if cr.flightInfo.first?.depRecieveBy == "" { require = require + "\n Arrive GiveBy"}
                if cr.flightInfo.first?.arriveRecieveBy == "" { require = require + "\n Arrive RecieveBy"}
                if cr.flightInfo.first?.painassessmentTypeId == 0{ require = require + "\n Pain Assessment"}
                observer.onError(caseError.requireField(message: require))
            }
            
            return Disposables.create()
            
        })
    }
    
    func deleteCase(index:Int,isNotSend:Bool){
        let cus = try! Realm().objects(Customer.self).filter("caseId = \(self.model[index].caseId)")
        let caseUserDefault = UserDefaults.standard
        let profileCustomer = "\(self.model[index].caseId)\(self.model[index].customerId)"
        caseUserDefault.removeObject(forKey: "caseResult\(profileCustomer)")
        let predicate = "caseId == \(self.model[index].caseId)"
        let progresson = realm.objects(Progression.self).filter(predicate)
        let medicalUsing = realm.objects(MedicalUsing.self).filter(predicate)
        let flightPerson = realm.objects(FlightPerson.self).filter(predicate)
        let intervention = realm.objects(Intervention.self).filter(predicate)
        let report = realm.objects(SummaryReport.self).filter(predicate)
        
        if isNotSend {
            for med in medicalUsing {
                let bagMed = realm.objects(MedicalBagDetailMedications.self).filter("id == \(med.itemId)").first
                try! realm.write {
                    if bagMed != nil {
                        bagMed?.amount = (bagMed?.amount)! + med.amount
                        self.realm.add(bagMed!,update: .all)
                    }
                    
                }
            }
        }
        
        
        let indexRemove = self.tempModel.index { (question) -> Bool in
            return question["customerId"] as? Int == cus.first?.customerId
        }
        
        if indexRemove != nil {
            self.tempModel.remove(at: indexRemove!)
        }
        
        
        try! realm.write {
            realm.delete(cus)
            realm.delete(progresson)
            realm.delete(medicalUsing)
            realm.delete(flightPerson)
            realm.delete(intervention)
            realm.delete(report)
        }
        
        self.model = Mapper<Customer>().mapArray(JSONArray: self.tempModel)
        self.change.onNext(.Success)
    }
}
