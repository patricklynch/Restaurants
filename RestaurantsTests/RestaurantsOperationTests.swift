//
//  RestaurantOperationTests.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/22/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import XCTest
@testable import Restaurants

class RestaurantOperationTests: XCTestCase {
    
    var operation: LoadRestaurants!
    
    override func setUp() {
        super.setUp()
        
        operation = LoadRestaurants()
        operation.bundle = Bundle(for: type(of: self))
        XCTAssertNil(operation.error)
        XCTAssertNil(operation.results)
    }
    
    func testOperationSuccess() {
        operation.filename = "test-restaurants-list.json"
        operation.main()
        
        XCTAssertNil(operation.error)
        XCTAssertNotNil(operation.results)
        XCTAssertEqual(operation.results?.count, 19)
    }
    
    func testOperationError() {
        operation.filename = "non-existent-file.json"
        operation.main()
        
        XCTAssertNotNil(operation.error)
        XCTAssertNil(operation.results)
    }
}
