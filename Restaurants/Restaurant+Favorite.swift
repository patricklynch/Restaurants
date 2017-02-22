//
//  FavoriteOperations.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/10/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import Foundation

struct DefaultsKeys {
    static let favorites: String = "com.lynchdev.Restaurants.DefaultsKeys.favorites"
}

extension Restaurant {
    
    func isFavorited(in defaults: UserDefaults = UserDefaults.standard) -> Bool {
        let favoritesArray = defaults.value(forKey: DefaultsKeys.favorites) as? Set<String> ?? []
        return favoritesArray.contains(self.name)
    }
    
    func favorite() {
        set(isFavorite: true)
    }
    
    func unfavorite() {
        set(isFavorite: false)
    }
    
    private func set(isFavorite: Bool, in defaults: UserDefaults = UserDefaults.standard) {
        guard !isFavorited(in: defaults) else {
            return
        }
        
        var favoritesArray = defaults.value(forKey: DefaultsKeys.favorites) as? [String] ?? []
        favoritesArray.append(self.name)
        defaults.set(favoritesArray, forKey: DefaultsKeys.favorites)
        defaults.synchronize()
    }
}
