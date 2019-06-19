//
//  DiktatBeautyTests.swift
//  DiktatBeautyTests
//
//  Created by Loris Pinna on 16/04/2019.
//  Copyright © 2019 Loris Pinna. All rights reserved.
//

import XCTest
@testable import DiktatBeauty

class DiktatBeautyTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testUnitConverter() {
        //Check si les pixels convertis donnent la bonne valeur
        XCTAssert(UnitConverter.pixelsToCentimeters(pixels: 1, dpi: 96) != 1)
        XCTAssert(UnitConverter.pixelsToCentimeters(pixels: 3, dpi: 96) == 0.079375)
        
        //Check si les centimetres convertis donnent la bonne valeur 
        XCTAssert(UnitConverter.centimetersToPixels(centimeters: 1, dpi: 96) != 1)
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
