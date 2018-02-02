//
//  CustomerSingleton.swift
//  MW EMR
//
//  Created by AunzNuBee on 5/9/2559 BE.
//  Copyright © 2559 AunzNuBee. All rights reserved.
//

import UIKit

class CustomerSingleton {
    static let sharedInstance = CustomerSingleton()
    private init(){
        
    }
    
    var customerProfile = Customer()
    
    func SetCustomerProfile(profile : Customer){
        self.customerProfile = profile
    }
}
