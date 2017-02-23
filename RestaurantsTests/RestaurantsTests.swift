//
//  RestaurantTests.swift
//  RestaurantsTests
//
//  Created by Patrick Lynch on 2/22/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Restaurants


class RestaurantTests: XCTestCase {
    
    var restaurant: Restaurant!
    
    override func setUp() {
        super.setUp()
        guard let restaurantJson = JSON.fromBundle(named: "test-restaurant.json"),
            let restaurant = Restaurant(json: restaurantJson) else {
                XCTFail("Failed to load restaurant for testing")
                return
        }
        self.restaurant = restaurant
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testParsing() {
        XCTAssertEqual(restaurant.name, "Tanoshii Sushi")
        XCTAssertEqual(restaurant.status, Restaurant.Status.open)
        XCTAssertNotNil(restaurant.imageUrl)
        XCTAssertEqual(restaurant.sortingValues.bestMatch, 0.0)
        XCTAssertEqual(restaurant.sortingValues.newest, 96.0)
        XCTAssertEqual(restaurant.sortingValues.ratingAverage, 4.5)
        XCTAssertEqual(restaurant.sortingValues.distance, 1190)
        XCTAssertEqual(restaurant.sortingValues.popularity, 17.0)
        XCTAssertEqual(restaurant.sortingValues.averageProductPrice, 1536)
        XCTAssertEqual(restaurant.sortingValues.deliveryCosts, 200)
        XCTAssertEqual(restaurant.sortingValues.minCost, 1000)
    }
}
