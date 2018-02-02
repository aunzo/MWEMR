//
//  MenuViewModel.swift
//  MW EMR
//
//  Created by Patarapon Tokham on 4/21/2559 BE.
//  Copyright © 2559 AunzNuBee. All rights reserved.
//

import UIKit 

class MenuViewModel {
    var menus = [Menu]()
    
    init() {
        menus.append(Menu(iconName: "menu1", titleMenu: "E-Learning"))
        menus.append(Menu(iconName: "menu2", titleMenu: "Medical Bag"))
        menus.append(Menu(iconName: "menu3", titleMenu: "Case"))
        menus.append(Menu(iconName: "menu4", titleMenu: "Consult"))
        menus.append(Menu(iconName: "menu5", titleMenu: "Preflight"))
        menus.append(Menu(iconName: "menu6", titleMenu: "Flight Information"))
        menus.append(Menu(iconName: "menu7", titleMenu: "Progession"))
        menus.append(Menu(iconName: "menu8", titleMenu: "Medication"))
        menus.append(Menu(iconName: "menu9", titleMenu: "Suggestion"))
    }
    
    func getTitleMenu(index:Int) -> String {
        return menus[index].titleMenu
    }
    
    func geticonName(index:Int) -> String {
        return menus[index].iconName
    }
}
