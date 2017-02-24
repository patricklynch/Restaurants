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
    
    static var all: [SortOptions] {
        return [bestMatch, newest, ratingAverage, distance, popularity, averageProductPrice, deliveryCosts, minCost]
    }
    
    static var defaultCase: SortOptions {
        return bestMatch
    }
    
    var label: String {
        switch self {
        case .bestMatch:            return NSLocalizedString("sortOption.bestMatch", comment: "")
        case .newest:               return NSLocalizedString("sortOption.newest", comment: "")
        case .ratingAverage:        return NSLocalizedString("sortOption.ratingAverage", comment: "")
        case .distance:             return NSLocalizedString("sortOption.distance", comment: "")
        case .popularity:           return NSLocalizedString("sortOption.popularity", comment: "")
        case .averageProductPrice:  return NSLocalizedString("sortOption.averageProductPrice", comment: "")
        case .deliveryCosts:        return NSLocalizedString("sortOption.deliveryCosts", comment: "")
        case .minCost:              return NSLocalizedString("sortOption.minCost", comment: "")
        }
    }
    
    func sorted(from objects: [Restaurant]) -> [Restaurant] {
        switch self {
        case .bestMatch:
            return objects.sorted { $0.sortingValues.bestMatch < $1.sortingValues.bestMatch }
        
        case .newest:
            return objects.sorted { $0.sortingValues.newest < $1.sortingValues.newest }
        
        case .ratingAverage:
            return objects.sorted { $0.sortingValues.ratingAverage < $1.sortingValues.ratingAverage }
        
        case .distance:
            return objects.sorted { $0.sortingValues.distance < $1.sortingValues.distance }
        
        case .popularity:
            return objects.sorted { $0.sortingValues.popularity < $1.sortingValues.popularity }
        
        case .averageProductPrice:
            return objects.sorted { $0.sortingValues.averageProductPrice < $1.sortingValues.averageProductPrice }
        
        case .deliveryCosts:
            return objects.sorted { $0.sortingValues.deliveryCosts < $1.sortingValues.deliveryCosts }
            
        case .minCost:
            return objects.sorted { $0.sortingValues.minCost < $1.sortingValues.minCost }
        }
    }
}
