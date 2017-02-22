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
    
    static let ratingTotal: Int = 5
    
    enum Status: String {
        case open, closed, orderAhead = "order ahead"
        
        var text: String {
            switch self {
            case .open:         return NSLocalizedString("status.open", comment: "")
            case .closed:       return NSLocalizedString("status.closed", comment: "")
            case .orderAhead:   return NSLocalizedString("status.orderAhead", comment: "")
            }
        }
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
    
    let name: String
    let status: Status
    let sortingValues: SortingValues
    let rating: Int
    
    init?(json: JSON) {
        guard let name = json["name"].string,
            let status = Status(rawValue: json["status"].stringValue),
            let rating = json["rating"].int,
            let sortingValues = SortingValues(json:json["sortingValues"]) else {
                return nil
        }
        self.name = name
        self.status = status
        self.rating = rating
        self.sortingValues = sortingValues
    }
    
    // MARK: - Hashable
    
    var hashValue: Int {
        return name.hashValue
    }
    
    // MARK: - Equatable
    
    static func ==(lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.name == rhs.name
    }
}
