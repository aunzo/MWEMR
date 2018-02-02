//
//  FlightPerson.swift
//  MW EMR
//
//  Created by AunzNuBee on 5/14/2559 BE.
//  Copyright © 2559 AunzNuBee. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class FlightPerson: Object,Mappable {
    
    @objc dynamic var flightPersonId = 1
    @objc dynamic var customerId = 0
    @objc dynamic var caseId = 0
    @objc dynamic var name = ""
    @objc dynamic var position = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        flightPersonId <- map["flightPersonId"]
        customerId <- map["customerId"]
        customerId <- map["caseId"]
        name <- map["name"]
        position <- map["position"]
    }
    
    override static func primaryKey() -> String? {
        return "flightPersonId"
    }
}
