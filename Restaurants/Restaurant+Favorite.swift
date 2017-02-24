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
        let favoritesArray = defaults.value(forKey: DefaultsKeys.favorites) as? [String] ?? []
        return favoritesArray.contains(self.name)
    }
    
    func set(isFavorite: Bool, in defaults: UserDefaults = UserDefaults.standard) {
        var favoritesArray = defaults.value(forKey: DefaultsKeys.favorites) as? [String] ?? []
        if isFavorite {
            favoritesArray.append(self.name)
        } else {
            favoritesArray = favoritesArray.filter { $0 != self.name }
        }
        defaults.set(favoritesArray, forKey: DefaultsKeys.favorites)
        defaults.synchronize()
    }
}
