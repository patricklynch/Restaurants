//
//  Restaurant+Search.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/24/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import Foundation

extension Restaurant {
    
    static func search(from objects: [Restaurant], matching searchTerm: String) -> [Restaurant] {
        guard searchTerm.containsNonSpaceCharacter() else {
            return []
        }
        let sanitzedTerm = searchTerm.lowercased()
        return objects.filter { $0.name.matches(sanitzedTerm) }
    }
}

fileprivate extension String {
    
    func matches(_ searchTerm: String) -> Bool {
        if searchTerm.characters.count == 1 {
            let words = lowercased().components(separatedBy: " ")
            return words.contains { $0.characters.first == searchTerm.characters.first }
        } else {
            return lowercased().contains(searchTerm)
        }
    }
    
    func containsNonSpaceCharacter() -> Bool {
        let space = " ".characters.first!
        return !characters.filter { $0 != space }.isEmpty
    }
}
