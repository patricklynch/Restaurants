//
//  SortingTests.swift
//  RestaurantsTests
//
//  Created by Patrick Lynch on 2/22/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Restaurants

class SortingTests: XCTestCase {
    
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
    
    func testBestMatch() {
        let sorted = SortOption.bestMatch.sorted(from: restaurants)
        
        var prevLoop: Restaurant?
        for current in sorted {
            guard let prev = prevLoop else { continue }
            XCTAssertLessThan(current.sortingValues.bestMatch, prev.sortingValues.bestMatch)
            prevLoop = current
        }
    }
    
    func testNewest() {
        let sorted = SortOption.newest.sorted(from: restaurants)
        
        var prevLoop: Restaurant?
        for current in sorted {
            guard let prev = prevLoop else { continue }
            XCTAssertLessThan(current.sortingValues.newest, prev.sortingValues.newest)
            prevLoop = current
        }
    }
    
    func testRatingAverage() {
        let sorted = SortOption.ratingAverage.sorted(from: restaurants)
        
        var prevLoop: Restaurant?
        for current in sorted {
            guard let prev = prevLoop else { continue }
            XCTAssertLessThan(current.sortingValues.ratingAverage, prev.sortingValues.ratingAverage)
            prevLoop = current
        }
    }
    
    func testDistance() {
        let sorted = SortOption.distance.sorted(from: restaurants)
        
        var prevLoop: Restaurant?
        for current in sorted {
            guard let prev = prevLoop else { continue }
            XCTAssertLessThan(current.sortingValues.distance, prev.sortingValues.distance)
            prevLoop = current
        }
    }
    
    func testPopularity() {
        let sorted = SortOption.popularity.sorted(from: restaurants)
        
        var prevLoop: Restaurant?
        for current in sorted {
            guard let prev = prevLoop else { continue }
            XCTAssertLessThan(current.sortingValues.popularity, prev.sortingValues.popularity)
            prevLoop = current
        }
    }
    
    func testAverageProductPrice() {
        let sorted = SortOption.averageProductPrice.sorted(from: restaurants)
        
        var prevLoop: Restaurant?
        for current in sorted {
            guard let prev = prevLoop else { continue }
            XCTAssertLessThan(current.sortingValues.averageProductPrice, prev.sortingValues.averageProductPrice)
            prevLoop = current
        }
    }
    
    func testDeliveryCosts() {
        let sorted = SortOption.deliveryCosts.sorted(from: restaurants)
        
        var prevLoop: Restaurant?
        for current in sorted {
            guard let prev = prevLoop else { continue }
            XCTAssertLessThan(current.sortingValues.deliveryCosts, prev.sortingValues.deliveryCosts)
            prevLoop = current
        }
    }
}
