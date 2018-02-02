import UIKit
import Alamofire
import RxSwift
import RxCocoa
import ObjectMapper

class Connection {
    func get<T : Mappable>(model : T,path: String) -> Observable<[T]>{
        return Observable.create({ (observer) -> Disposable in
            Alamofire.request(path, method: .get).responseJSON(completionHandler: { (res) in
                if res.result.isSuccess {
                    if res.response?.statusCode == 200 {
                        let model = Mapper<T>().mapArray(JSONObject:res.result.value)
                        if model != nil {
                            observer.onNext(model!)
                        }else{
                            
                        }
                    }else{
                        observer.onError(res.result.error!)
                    }
                }else{
                    observer.onError(res.result.error!)
                }

            })
            
            return Disposables.create()
        })
    }
    
    func changePassportID(customerID:Int, passport:String) -> Observable<Void>{
        return Observable.create({ (observer) -> Disposable in
            Alamofire.request(Constant.changePassportID, method: .post, parameters: ["customerID":customerID, "passportID":passport], encoding: JSONEncoding.default).responseString(completionHandler: { (res) in
                if res.result.isSuccess {
                    if res.result.value! == "Success" {
                        observer.onCompleted()
                    }else{
                        observer.onError(caseError.UnexpectedError(message: res.result.value ?? ""))
                    }
                }
            })
            
            return Disposables.create()
        })
    }
    
    func uploadCase(data: [String:Any]) -> Observable<Void>{
        return Observable.create({ (observer) -> Disposable in
            Alamofire.request(Constant.uploadCase, method: .post, parameters: data, encoding: JSONEncoding.default).responseString(completionHandler: { (res) in
                if res.result.value! == "Success" {
                    observer.onCompleted()
                }else{
                    observer.onError(caseError.UnexpectedError(message: res.result.value ?? ""))
                }
            })
            
            return Disposables.create()
        })
    }
    
    func uploadBag(bagId: Int) -> Observable<Void>{
        return Observable.create({ (observer) -> Disposable in
            Alamofire.request(Constant.uploadBag, method: .get, parameters: ["bagId":bagId]).responseString(completionHandler: { (res) in
                if res.result.value! == "Success" {
                    observer.onCompleted()
                }else{
                    observer.onError(res.result.error!)
                }
                
            })
            
            return Disposables.create()
        })
    }
    
    func getRawData(path: String) -> Observable<Any>{
        return Observable.create({ (observer) -> Disposable in
            Alamofire.request(path, method: .get).responseJSON(completionHandler: { (res) in
                if res.result.isSuccess {
                    if res.response?.statusCode == 200 {
                            observer.onNext(res.result.value!)
                    }else{
                        observer.onError(res.result.error!)
                    }
                }else{
                    observer.onError(res.result.error!)
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
