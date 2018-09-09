//
//  String+Empty.swift
//  MW EMR
//
//  Created by Patarapon  Tokham on 11/8/2561 BE.
//  Copyright © 2561 AunzNuBee. All rights reserved.
//

import Foundation

extension String
{
    func mapEmptyStringToNil() -> String?
    {
        if self.isEmpty
        {
            return nil
        }
        else
        {
            return self
        }
    }
}
