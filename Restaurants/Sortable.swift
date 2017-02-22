//
//  Sortable.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/22/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import UIKit

protocol Sortable {
    var sortOption: SortOptions? { set get }
}

enum SortOptions {
    case bestMatch, newest, ratingAverage, distance, popularity, averageProductPrice, deliveryCosts, minCost
    
    var label: String {
        return "A"
        
        switch self {
        case .bestMatch:
            return NSLocalizedString("sortOption.bestMatch", comment: "")
        case .newest:
            return NSLocalizedString("sortOption.bestMatch", comment: "")
        case .ratingAverage:
            return NSLocalizedString("sortOption.bestMatch", comment: "")
        case .distance:
            return NSLocalizedString("sortOption.bestMatch", comment: "")
        case .popularity:
            return NSLocalizedString("sortOption.bestMatch", comment: "")
        case .averageProductPrice:
            return NSLocalizedString("sortOption.bestMatch", comment: "")
        case .deliveryCosts:
            return NSLocalizedString("sortOption.bestMatch", comment: "")
        case .minCost:
            return NSLocalizedString("sortOption.bestMatch", comment: "")
        }
    }
    
    static var all: [SortOptions] {
        return [bestMatch, newest, ratingAverage, distance, popularity, averageProductPrice, deliveryCosts, minCost]
    }
}

