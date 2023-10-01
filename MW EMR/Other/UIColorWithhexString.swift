//
//  UIColorWithHex.swift
//  M51
//
//  Created by Patarapon Tokham on 9/17/2557 BE.
//  Copyright (c) 2557 Piesoft Co., Ltd. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(hexString: String) {
        var red: CGFloat   = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat  = 0.0
        var alpha: CGFloat = 1.0
        
        if hexString.hasPrefix("#") {
            let index = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexs = hexString.substring(from: index)
            let scanner = Scanner(string: hexs)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexInt64(&hexValue) {
                if hexs.count == 6 {
                    red   = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)  / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF) / 255.0
                } else if hexs.count == 8 {
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                } else {
                    print("invalid rgb string, length should be 7 or 9", terminator: "")
                }
            } else {
                print("scan hex error")
            }
        } else {
            print("invalid rgb string, missing '#' as prefix", terminator: "")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
}
