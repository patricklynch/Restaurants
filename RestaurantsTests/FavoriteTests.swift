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
    var defaults: UserDefaults!
    
    override func setUp() {
        super.setUp()
        guard let restaurantJson = JSON.fromBundle(named: "test-restaurant.json"),
            let restaurant = Restaurant(json: restaurantJson) else {
                XCTFail("Failed to load restaurant for testing")
                return
        }
        self.restaurant = restaurant
        self.defaults = UserDefaults(suiteName: "com.lynchdev.Restaurants.unitTests")
        restaurant.set(isFavorite: false, in: defaults)
    }
    
    override func tearDown() {
        super.tearDown()
        restaurant.set(isFavorite: false, in: defaults)
    }
    
    func testToggle() {
        XCTAssertFalse(restaurant.isFavorited(in: defaults))
        
        restaurant.set(isFavorite: true, in: defaults)
        XCTAssert(restaurant.isFavorited(in: defaults))
        
        restaurant.set(isFavorite: false, in: defaults)
        XCTAssertFalse(restaurant.isFavorited(in: defaults))
    }
    
    func testRepeat() {
        XCTAssertFalse(restaurant.isFavorited(in: defaults))
        
        restaurant.set(isFavorite: false, in: defaults)
        XCTAssertFalse(restaurant.isFavorited(in: defaults))
        
        restaurant.set(isFavorite: true, in: defaults)
        XCTAssert(restaurant.isFavorited(in: defaults))
        
        restaurant.set(isFavorite: true, in: defaults)
        XCTAssert(restaurant.isFavorited(in: defaults))
    }
}
