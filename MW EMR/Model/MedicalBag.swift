//
//  MedicalBag.swift
//  MW EMR
//
//  Created by AunzNuBee on 6/1/2559 BE.
//  Copyright © 2559 AunzNuBee. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class MedicalBag: Object,Mappable {
    
    @objc dynamic var bag_id = 0
    @objc dynamic var name = ""
    
    required convenience init?(map: ObjectMapper.Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: ObjectMapper.Map) {
        bag_id <- map["BAG_ID"]
        name <- map["BAG_NAME"]
        
    }
    
    override static func primaryKey() -> String? {
        return "bag_id"
    }
}
