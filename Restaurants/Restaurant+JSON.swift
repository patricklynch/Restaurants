//
//  Restaurant+JSON.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/24/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import Foundation
import SwiftyJSON

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
