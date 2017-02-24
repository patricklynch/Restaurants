//
//  Restaurant.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/22/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import Foundation

struct Restaurant: Equatable, Hashable {
    
    static let averageRatingTotal: Int = 5
    static let priceRatingTotal: Int = 3
    
    enum Status: String {
        case open, closed, orderAhead = "order ahead"
    }
    
    struct SortingValues {
        let bestMatch: Float
        let newest: Float
        let ratingAverage: Float
        let distance: Int
        let popularity: Float
        let averageProductPrice: Int
        let deliveryCosts: Int
        let minCost: Int
    }
    
    let name: String
    let status: Status
    let sortingValues: SortingValues
    let imageUrl: URL
    
    // MARK: - Hashable
    
    var hashValue: Int {
        return name.hashValue
    }
    
    // MARK: - Equatable
    
    static func ==(lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.name == rhs.name
    }
    
    // MARK: - Number formatters
    
    static var distanceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_DE")
        formatter.allowsFloats = true
        return formatter
    }()
    
    static var currentFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_DE")
        return formatter
    }()
}
