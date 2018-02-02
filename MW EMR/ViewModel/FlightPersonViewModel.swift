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
    
    func load(){
        let items = realm.objects(FlightPerson.self).filter("caseId == \(customer.caseId)")
        self.flightPersonItems = items
        self.flightPersonChange.onNext(.list)
    }
    
    func addOrUpdate(item:[String:String]){
        var itemEdit = item
        
        try! realm.write {
            if itemEdit["flightPersonId"] == nil {
                let obj = realm.objects(FlightPerson.self).last
                let insertObj = FlightPerson()
                if obj != nil {
                    insertObj.flightPersonId = (obj?.flightPersonId)! + 1
                }
                insertObj.customerId = customer.customerId
                insertObj.caseId = customer.caseId
                insertObj.name = itemEdit["name"]!
                insertObj.position  = itemEdit["position"]!
                realm.add(insertObj, update: false)
            }else{
                realm.create(FlightPerson.self, value: itemEdit, update: true)
            }
        }
        
        self.flightPersonChange.onNext(.addOrUpdate)
        self.flightPersonChange.onNext(.list)
    }
    
    func remove(id:String){
        let itemFind = realm.objects(FlightPerson.self).filter("flightPersonId == \(id)")
        
        try! realm.write {
            realm.delete(itemFind)
            self.flightPersonChange.onNext(.delete)
        }
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
