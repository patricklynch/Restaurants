//
//  Restaurant+Convenience.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/24/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import Foundation

extension Restaurant {
    
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

extension Restaurant.Status {
    
    var description: String {
        switch self {
        case .open:         return "Open"
        case .closed:       return "Closed"
        case .orderAhead:   return "Order Ahread"
        }
    }
}
