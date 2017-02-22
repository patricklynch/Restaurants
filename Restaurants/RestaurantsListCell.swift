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
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var distanceLabel: UILabel!
    @IBOutlet private weak var priceRatingLabel: UILabel!
    @IBOutlet private weak var deliveryCostLabel: UILabel!
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var ratingView: RatingView!
    
    struct ViewModel {
        let title: String
        let status: String
        let distance: String
        let averageRating: Rating
        let priceRating: Rating
        let deliveryCost: String
        let imageUrl: URL
    }
    
    var viewData: ViewModel? {
        didSet {
            if let viewData = viewData {
                titleLabel.text = viewData.title
                statusLabel.text = viewData.status
                distanceLabel.text = viewData.distance
                priceRatingLabel.text = "\(viewData.priceRating.current)"
                ratingView.rating = viewData.averageRating
                deliveryCostLabel.text = "Delivery cost: \(viewData.deliveryCost)"
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
