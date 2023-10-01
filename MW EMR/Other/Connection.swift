import UIKit
import Alamofire
import RxSwift
import RxCocoa
import ObjectMapper

class Connection {
    func get<T : Mappable>(model : T,path: String) -> Observable<[T]>{
        return Observable.create({ (observer) -> Disposable in
            AF.request(path, method: .get).responseJSON(completionHandler: { (res) in
                if res.response?.statusCode == 200 {
                    let model = Mapper<T>().mapArray(JSONObject:res.value)
                    if model != nil {
                        observer.onNext(model!)
                    }else{
                        observer.onError(res.error!)
                    }
                }
                else
                {
                    observer.onError(res.error!)
                }
            })
            
            return Disposables.create()
        })
    }
    
    func changePassportID(customerID:Int, passport:String) -> Observable<Void>{
        return Observable.create({ (observer) -> Disposable in
            AF
                .request(
                    Constant.changePassportID,
                    method: .post,
                    parameters: ["customerID":customerID, "passportID":passport],
                    encoding: JSONEncoding.default)
                .responseString(completionHandler: { (res) in
                    if res.value == "Success"
                    {
                        observer.onCompleted()
                    }
                    else
                    {
                        observer.onError(caseError.UnexpectedError(message: res.value ?? ""))
                    }
                })
            
            return Disposables.create()
        })
    }
    
    func uploadCase(data: [String:Any]) -> Observable<Void>{
        return Observable.create({ (observer) -> Disposable in
            AF
                .request(
                    Constant.uploadCase,
                    method: .post,
                    parameters: data,
                    encoding: JSONEncoding.default)
                .responseString(completionHandler: { (res) in
                    if res.value == "Success"
                    {
                        observer.onCompleted()
                    }
                    else
                    {
                        observer.onError(caseError.UnexpectedError(message: res.value ?? ""))
                    }
                })
            
            return Disposables.create()
        })
    }
    
    func uploadBag(bagId: Int) -> Observable<Void>{
        return Observable.create({ (observer) -> Disposable in
            AF.request(Constant.uploadBag, method: .get, parameters: ["bagId":bagId]).responseString(completionHandler: { (res) in
                if res.value == "Success" {
                    observer.onCompleted()
                }else{
                    observer.onError(res.error!)
                }
                
            })
            
            return Disposables.create()
        })
    }
    
    func getRawData(path: String) -> Observable<Any>{
        return Observable.create({ (observer) -> Disposable in
            AF.request(path, method: .get).responseString(completionHandler: { res in
                if res.response?.statusCode == 200 
                {
                        observer.onNext(res.value!)
                }
                else
                {
                    observer.onError(res.error!)
                }
            })
            return Disposables.create()
        })
    }
    
}

enum caseError: Error {
    case requireField (message: String)
    case notSend
    case UnexpectedError(message: String)
    
}
