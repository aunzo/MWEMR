//
//  ArrayTransform.swift
//  ThaiFlightInfo
//
//  Created by Patarapon Tokham on 2/29/2559 BE.
//  Copyright © 2559 Patarapon Tokham. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper

class ArrayTransform<T:RealmSwift.Object> : TransformType where T:Mappable {
    typealias Object = List<T>
    typealias JSON = [AnyObject]
    
    let mapper = Mapper<T>()
    
    func transformFromJSON(_ value: Any?) -> List<T>? {
        let results = List<T>()
        if let value = value as? [AnyObject] {
            for json in value {
                if let obj = mapper.map(JSONObject: json) {
                    results.append(obj)
                }
            }
        }
        return results
        
    }
    
    func transformToJSON(_ value: List<T>?) -> Array<AnyObject>? {
        var results = [AnyObject]()
        if let value = value {
            for obj in value {
                let json = mapper.toJSON(obj)
                results.append(json as AnyObject)
            }
        }
        return results
    }
    
}
