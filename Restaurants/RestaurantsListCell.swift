//
//  RestaurantsListCell.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/9/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import UIKit

struct Rating {
    let current: Int
    let total: Int
}

class RestaurantListCell: UITableViewCell, FavoritableView {
    
    @IBOutlet private weak var roundedRectView: UIView!
    @IBOutlet private weak var shadowContainerView: UIView!
    @IBOutlet private weak var favoriteButton: FavoriteButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var ratingView: RatingView!
    
    struct ViewData {
        let title: String
        let subtitle: String
        let rating: Rating
        let imageUrl: URL
    }
    
    var viewData: ViewData? {
        didSet {
            if let viewData = viewData {
                titleLabel.text = viewData.title
                subtitleLabel.text = viewData.subtitle
                ratingView.rating = viewData.rating
                
                thumbnailImageView.fadeInImage(at: viewData.imageUrl)
            }
        }
    }
    
    // MARK: - FavoritableView
    
    weak var favoriteDelegate: FavoritableViewDelegate?
    
    var isFavorited: Bool  {
        set {
            favoriteButton.isFavorited = newValue
        }
        get {
            return favoriteButton.isFavorited
        }
    }
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        isFavorited = false
        
        favoriteButton.layer.shadowRadius = 3.0
        favoriteButton.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        favoriteButton.layer.shadowColor = UIColor.black.cgColor
        favoriteButton.layer.shadowOpacity = 0.75
        
        roundedRectView.layer.cornerRadius = 5.0
        
        shadowContainerView.layer.cornerRadius = 5.0
        shadowContainerView.layer.shadowRadius = 3.0
        shadowContainerView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        shadowContainerView.layer.shadowColor = UIColor.black.cgColor
        shadowContainerView.layer.shadowOpacity = 0.25
    }
    
    // MARK: - Actions
    
    @IBAction private func onFavoriteValueChanged() {
        favoriteDelegate?.cellDidToggleFavorite(self)
    }
}
