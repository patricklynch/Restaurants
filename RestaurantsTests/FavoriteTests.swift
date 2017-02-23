//
//  FavoriteTests.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/23/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Restaurants

class FavoriteTests: XCTestCase {
    
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
    
    func testToggle() {
        XCTAssertFalse(restaurant.isFavorited())
        
        restaurant.favorite()
        XCTAssert(restaurant.isFavorited())
        
        restaurant.unfavorite()
        XCTAssertFalse(restaurant.isFavorited())
    }
    
    func testRepeat() {
        XCTAssertFalse(restaurant.isFavorited())
        
        restaurant.unfavorite()
        XCTAssertFalse(restaurant.isFavorited())
        
        restaurant.favorite()
        XCTAssert(restaurant.isFavorited())
        
        restaurant.favorite()
        XCTAssert(restaurant.isFavorited())
    }
}
