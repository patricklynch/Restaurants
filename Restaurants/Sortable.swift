//
//  Sortable.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/22/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import UIKit

protocol Sortable {
    var sortOption: SortOption { set get }
}

enum SortOption {
    case bestMatch, newest, ratingAverage, distance, popularity, averageProductPrice, deliveryCosts
    
    static var all: [SortOption] {
        return [bestMatch, newest, ratingAverage, distance, popularity, averageProductPrice, deliveryCosts]
    }
    
    static var defaultCase: SortOption {
        return bestMatch
    }
    
    var label: String {
        switch self {
        case .bestMatch:            return "Default"
        case .newest:               return "Newest"
        case .ratingAverage:        return "Rating"
        case .distance:             return "Distance"
        case .popularity:           return "Popularity"
        case .averageProductPrice:  return "Price"
        case .deliveryCosts:        return "Delivery"
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
        }
    }
}
