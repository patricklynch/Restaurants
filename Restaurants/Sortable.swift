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

protocol Sorter {
    func sorted(from objects: [Restaurant]) -> [Restaurant]
}

enum SortOptions {
    case bestMatch, newest, ratingAverage, distance, popularity, averageProductPrice, deliveryCosts, minCost
    
    var label: String {
        switch self {
        case .bestMatch:            return NSLocalizedString("sortOption.bestMatch", comment: "")
        case .newest:               return NSLocalizedString("sortOption.bestMatch", comment: "")
        case .ratingAverage:        return NSLocalizedString("sortOption.bestMatch", comment: "")
        case .distance:             return NSLocalizedString("sortOption.bestMatch", comment: "")
        case .popularity:           return NSLocalizedString("sortOption.bestMatch", comment: "")
        case .averageProductPrice:  return NSLocalizedString("sortOption.bestMatch", comment: "")
        case .deliveryCosts:        return NSLocalizedString("sortOption.bestMatch", comment: "")
        case .minCost:              return NSLocalizedString("sortOption.bestMatch", comment: "")
        }
    }
    
    var sorter: Sorter? {
        switch self {
        case .deliveryCosts:    return DeliveryCostSorter()
        default:                return DefaultSorter()
        }
    }
    
    static var all: [SortOptions] {
        return [bestMatch, newest, ratingAverage, distance, popularity, averageProductPrice, deliveryCosts, minCost]
    }
}

class DefaultSorter: Sorter {
    func sorted(from objects: [Restaurant]) -> [Restaurant] {
        return objects.sorted { $0.sortingValues.bestMatch < $1.sortingValues.bestMatch }
    }
}

class DeliveryCostSorter: Sorter {
    func sorted(from objects: [Restaurant]) -> [Restaurant] {
        return objects.sorted { $0.sortingValues.deliveryCosts < $1.sortingValues.deliveryCosts }
    }
}




/*
 
 }= filteredResults.sorted {
 switch sortOption {
 case .bestMatch:
 return $0.sortingValues.bestMatch < $1.sortingValues.bestMatch
 case .newest:
 return $0.sortingValues.newest < $1.sortingValues.newest
 case .ratingAverage:
 return $0.sortingValues.ratingAverage < $1.sortingValues.ratingAverage
 case .distance:
 return $0.sortingValues.distance < $1.sortingValues.distance
 case .popularity:
 return $0.sortingValues.popularity < $1.sortingValues.popularity
 case .averageProductPrice:
 return $0.sortingValues.averageProductPrice < $1.sortingValues.averageProductPrice
 case .deliveryCosts:
 return $0.sortingValues.deliveryCosts < $1.sortingValues.deliveryCosts
 case .minCost:
 return $0.sortingValues.minCost < $1.sortingValues.minCost
 }
 }
 */
