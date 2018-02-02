import UIKit
import RxSwift
import RxCocoa
import RealmSwift
import Alamofire
import ObjectMapper
import MBProgressHUD

class ElearningViewModel {
    private let connection = Connection()
    private let bag = DisposeBag()
    private var model:[Elearning] = []
    private let realm = try! Realm()
    private var request: Alamofire.Request?
    final private var tempModel:[[String:Any]] = []
    
    var change = PublishSubject<Void>()
    
    func load(view:UIView){
        MBProgressHUD.showAdded(to: view, animated: true)
        connection.get(model: Elearning(), path: Constant.elearningUrl)
            .subscribe(onNext: { (model) in
                self.model = model
                self.tempModel = model.toJSON()
                
                MBProgressHUD.hide(for: view, animated: true)
                self.change.onCompleted()
                }, onError: { (error) in
                    self.model = self.realm.objects(Elearning.self).toArray(ofType: Elearning.self)
                    MBProgressHUD.hide(for: view, animated: true)
                    self.change.onCompleted()
            }).disposed(by: bag)
    }
    
    func numberOfItems() -> Int {
        return self.model.count
    }
    
    func itemAt(index:Int) -> (name:String,path:String,type_name:String) {
        let item = self.model[index]
        return (item.name,item.path,item.type_name)
    }
    
    func itemIsDownloaded(index:Int) -> Bool {
//        let elearn = realm.objects(Elearning.self).toArray()
        let obj = realm.objects(Elearning.self).filter("file_id = \(self.model[index].file_id)").first
        
        if obj != nil {
            let pathComponent = "\(obj!.file_id)_\(obj!.name)_\(obj!.type_name).\(obj!.file_type)"
            print(pathComponent)
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
            if obj!.file_type == "pdf" {
                let document = ReaderDocument(filePath: documentsPath.appendingPathComponent(pathComponent), password: nil)
                
                if document != nil {
                    return true
                }else{
                    return false
                }
            }else{
                let image = UIImage(contentsOfFile: documentsPath.appendingPathComponent(pathComponent))
                
                if image != nil {
                    return true
                }else{
                    return false
                }
            }
            
        } else {
            return false
        }
    }
    
    func getTypeOfFile(index:Int) -> TypeFile {
        let item = realm.objects(Elearning.self).filter("file_id = \(self.model[index].file_id)").first
        if item?.file_type == "pdf" {
            return .pdf
        }else{
            return .image
        }
    }
    
    func downloadToLocal(index:Int) -> Observable<Float>{
        if let obj = model.filter({$0.file_id == self.model[index].file_id}).first {
            
            let typeFile = obj.path.split(separator: ".").map(String.init).last ?? "pdf"
            obj.file_type = typeFile
            try! realm.write {
                realm.add(obj,update: true)
            }
            
            let pathComponent = "\(obj.file_id)_\(obj.name)_\(obj.type_name).\(typeFile)"
            return Observable.create({ (observer) -> Disposable in
                self.request = Alamofire.download(obj.path, to: { (temporaryURL, response) -> (destinationURL: URL, options: DownloadRequest.DownloadOptions) in
                    let fileManager = FileManager.default
                    let directoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
                    
                    
                    return (directoryURL.appendingPathComponent(pathComponent),[.removePreviousFile, .createIntermediateDirectories])
                }).downloadProgress(closure: { (progress) in
                    DispatchQueue.main.async {
                        observer.onNext(Float(progress.fractionCompleted))
                    }
                }).response(completionHandler: { (response) in
                    observer.onNext(1)
                })
                return Disposables.create()
            })
        }else{
            return Observable.create({ (observer) -> Disposable in
                observer.onNext(1)
                return Disposables.create()
            })
        }
        
    }
    
    func cancelDownload(){
        self.request?.cancel()
    }
    
    func openElearningFile(index:Int) -> ReaderDocument? {
        if let obj = realm.objects(Elearning.self).filter("file_id = \(self.model[index].file_id)").first
        {
            let pathComponent = "\(obj.file_id)_\(obj.name)_\(obj.type_name).pdf"
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
            let document = ReaderDocument(filePath: documentsPath.appendingPathComponent(pathComponent), password: nil)
            
            return document
        }
        
        return nil
    }
    
    func openImageFile(index:Int) -> UIImage {
        if let obj = realm.objects(Elearning.self).filter("file_id = \(self.model[index].file_id)").first
        {
            let pathComponent = "\(obj.file_id)_\(obj.name)_\(obj.type_name).\(obj.file_type)"
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
            let image = UIImage(contentsOfFile: documentsPath.appendingPathComponent(pathComponent))
            
            return image ?? UIImage()
        }
        return UIImage()
    }
    
    func getImageName(index:Int) -> String {
        if let obj = realm.objects(Elearning.self).filter("file_id = \(self.model[index].file_id)").first
        {
            return obj.name
        }

        return ""
    }
    
    func removePdf(index:Int) -> Observable<Void> {
        
        return Observable.create({ (observer) -> Disposable in
            if let obj = self.realm.objects(Elearning.self).filter("file_id = \(self.model[index].file_id)").first
            {
                let pathComponent = "\(obj.file_id)_\(obj.name)_\(obj.type_name).\(obj.file_type)"
                
                do {
                    let fileManager = FileManager.default
                    let documentDirectoryURLs = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
                    
                    if let filePath = documentDirectoryURLs.first?.appendingPathComponent(pathComponent).path {
                        try fileManager.removeItem(atPath: filePath)
                    }
                    try! self.realm.write {
                        self.realm.delete(obj)
                    }
                    if self.tempModel.isEmpty
                    {
                        self.model = self.realm.objects(Elearning.self).toArray(ofType: Elearning.self)
                    }
                    else
                    {
                        self.model = Mapper<Elearning>().mapArray(JSONArray: self.tempModel)
                    }
                    observer.onNext(())
                } catch let error as NSError {
                    print("ERROR: \(error)")
                    observer.onError(error)
                }
            }
            
            
            return Disposables.create()
        })
    }
}
