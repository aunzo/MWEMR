//
//  MasterData.swift
//  MW EMR
//
//  Created by AunzNuBee on 5/11/2559 BE.
//  Copyright © 2559 AunzNuBee. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class MasterData: Object,Mappable {
    
    @objc dynamic var masterID = 0
    @objc dynamic var name = ""
    @objc dynamic var fieldID = 0
    
    required convenience init?(map: ObjectMapper.Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: ObjectMapper.Map) {
        masterID <- map["MD_ID"]
        name <- map["MD_DISPLAY"]
        fieldID <- map["MF_MF_ID"]
        
    }
    
    override static func primaryKey() -> String? {
        return "masterID"
    }

}
