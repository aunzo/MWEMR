//
//  Results.swift
//  MW EMR
//
//  Created by AunzNuBee on 5/8/2559 BE.
//  Copyright © 2559 AunzNuBee. All rights reserved.
//

import UIKit
import RealmSwift

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        
        return array
    }
}

