//
//  OtherPhysicalViewModel.swift
//  MW EMR
//
//  Created by AunzNuBee on 5/14/2559 BE.
//  Copyright © 2559 AunzNuBee. All rights reserved.
//

import UIKit

class FlightPersonViewModel:PreFlightViewModel {
    private let customer = CustomerSingleton.sharedInstance.customerProfile
    
    func load()
    {
        flightPersonItems = realm.objects(FlightPerson.self).filter("caseId == \(customer.caseId)")
        flightPersonChange.onNext(.list)
    }
    
    private func reload()
    {
        flightPersonChange.onNext(.addOrUpdate)
        flightPersonChange.onNext(.list)
    }
    
    func add(item: FlightPerson)
    {
        realm.beginWrite()
        if let obj = realm.objects(FlightPerson.self).last
        {
            item.flightPersonId = obj.flightPersonId + 1
        }
        item.customerId = customer.customerId
        item.caseId = customer.caseId
        realm.add(item, update: .error)
        
        try? realm.commitWrite()
        
        reload()
    }
    
    func update(item: FlightPerson)
    {
        realm.beginWrite()
        
        item.customerId = customer.customerId
        item.caseId = customer.caseId
        
        realm.create(FlightPerson.self, value: item, update: .all)
        
        try? realm.commitWrite()
        
        reload()
    }
    
    func remove(id: String)
    {
        realm.beginWrite()
        
        realm.delete(realm.objects(FlightPerson.self).filter("flightPersonId == " + id))
        flightPersonChange.onNext(.delete)
        
        try? realm.commitWrite()
    }
    
    func numberOfItems() -> Int {
        return self.flightPersonItems?.count ?? 0
    }
    
    func listItem(index:Int) -> [String:String] {
        let item : FlightPerson = self.flightPersonItems![index]
        let id = item.flightPersonId 
        let name = item.name 
        let postion = item.position 
        return ["id":"\(id)","name":name,"position":postion]
    }
}
