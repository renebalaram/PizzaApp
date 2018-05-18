//
//  PizzaAppTests.swift
//  PizzaAppTests
//
//  Created by mac on 5/8/18.
//  Copyright © 2018 mobileappscompany. All rights reserved.
//

import XCTest
@testable import PizzaApp

class PizzaAppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testCount() {
        let count = Preferences.pizzaCount
        XCTAssert(count == 20)
    }
    
    func testSetCount() {
        Preferences.setPizzaCount(to: 30)
        let count = Preferences.pizzaCount
        XCTAssertEqual(count,30)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
