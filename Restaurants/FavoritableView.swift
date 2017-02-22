//
//  FavoritableView.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/11/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import Foundation

/// Defines an object that represents an UI component that is interacted with and
/// indicates the favorited state.
protocol FavoritableView: class {
    var isFavorited: Bool { get set }
    var favoriteDelegate: FavoritableViewDelegate? { get set }
}

/// Defines an object that updates its data model or backing store according to the current
/// favorited state when the `FavoriteableView` has been interacted with.
protocol FavoritableViewDelegate: class {
    func cellDidToggleFavorite(_ view: FavoritableView)
}
