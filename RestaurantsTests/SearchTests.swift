//
//  SearchTests.swift
//  RestaurantsTests
//
//  Created by Patrick Lynch on 2/22/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Restaurants

class SearchTests: XCTestCase {
    
    var restaurants: [Restaurant]!
    
    override func setUp() {
        super.setUp()
        guard let json = JSON.fromBundle(named: "test-restaurants-list.json") else {
            XCTFail("Failed to load restaurant for testing")
            return
        }
        restaurants = json["restaurants"].arrayValue.flatMap { Restaurant(json: $0) }
        XCTAssertFalse(restaurants.isEmpty, "Failed to load restaurant for testing")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCapitalized() {
        let searchTerm = "Sushi"
        let results = Restaurant.search(from: restaurants, matching: searchTerm)
        XCTAssertEqual(results.count, 4)
    }
    
    func testLowercase() {
        let searchTerm = "sushi"
        let results = Restaurant.search(from: restaurants, matching: searchTerm)
        XCTAssertEqual(results.count, 4)
    }
    
    func testUppercase() {
        let searchTerm = "SUSHI"
        let results = Restaurant.search(from: restaurants, matching: searchTerm)
        XCTAssertEqual(results.count, 4)
    }
    
    func testEmpty() {
        let searchTerm = ""
        let results = Restaurant.search(from: restaurants, matching: searchTerm)
        XCTAssert(results.isEmpty)
    }
}
