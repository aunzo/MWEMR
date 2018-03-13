//
//  MWEMRUITest.swift
//  MWEMRUITest
//
//  Created by Patarapon Tokham on 3/2/2561 BE.
//  Copyright © 2561 AunzNuBee. All rights reserved.
//

import XCTest

class MWEMRUITest: XCTestCase
{
        
    override func setUp()
    {
        super.setUp()
    }
    
    func testfirstScreenshots()
    {
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        snapshot("0-Home")
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
}
