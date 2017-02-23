//
//  Restaurant.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/22/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import Foundation
import SwiftyJSON

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

extension Restaurant.SortingValues {
    
    init?(json: JSON) {
        guard let bestMatch = json["bestMatch"].float,
            let newest = json["newest"].float,
            let ratingAverage = json["ratingAverage"].float,
            let distance = json["distance"].int,
            let popularity = json["popularity"].float,
            let averageProductPrice = json["averageProductPrice"].int,
            let deliveryCosts = json["deliveryCosts"].int,
            let minCost = json["minCost"].int else {
                return nil
        }
        self.bestMatch = bestMatch
        self.newest = newest
        self.ratingAverage = ratingAverage
        self.distance = distance
        self.popularity = popularity
        self.averageProductPrice = averageProductPrice
        self.deliveryCosts = deliveryCosts
        self.minCost = minCost
    }
}

extension Restaurant {
    
    init?(json: JSON) {
        guard let name = json["name"].string,
            let imageUrl = json["imageUrl"].url ?? URL(string: "google.com"),
            let status = Status(rawValue: json["status"].stringValue),
            let sortingValues = SortingValues(json:json["sortingValues"]) else {
                return nil
        }
        self.name = name
        self.status = status
        self.sortingValues = sortingValues
        self.imageUrl = imageUrl
    }
}

extension Restaurant.Status {
    
    var description: String {
        switch self {
        case .open:         return NSLocalizedString("status.open", comment: "")
        case .closed:       return NSLocalizedString("status.closed", comment: "")
        case .orderAhead:   return NSLocalizedString("status.orderAhead", comment: "")
        }
    }
}

extension Restaurant {

    // MARK: - Conveneince getters
    
    var averageRating: Rating {
        return Rating(
            current: Int(sortingValues.ratingAverage),
            total: Restaurant.averageRatingTotal
        )
    }
    
    var priceDescription: String {
        let number = Float(sortingValues.averageProductPrice) / 100.0
        guard let string = Restaurant.currentFormatter.string(from: NSNumber(value: number)) else {
            return ""
        }
        return "Average Item: \(string)"
    }
    
    var deliveryDescription: String {
        let number = Float(sortingValues.deliveryCosts) / 100.0
        guard let string = Restaurant.currentFormatter.string(from: NSNumber(value: number)) else {
            return ""
        }
        return "Delivery: \(string)"
    }
    
    var locationDescription: String {
        let distance = Float(sortingValues.distance) / 1000.0
        guard let string = Restaurant.distanceFormatter.string(from: NSNumber(value: distance)) else {
            return ""
        }
        return "\(string) km away"
    }
}
