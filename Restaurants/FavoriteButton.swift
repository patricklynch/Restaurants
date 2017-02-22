//
//  FavoriteButton.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/12/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import UIKit

class FavoriteButton: UIButton {
    
    let favoriteImage = UIImage(named:"favorite-stroked")!
    let unfavoriteImage = UIImage(named:"favorite-solid")!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addTarget(self, action: #selector(onToggle), for: .touchUpInside)
    }
    
    @objc private func onToggle() {
        isFavorited = !isFavorited
        sendActions(for: .valueChanged)
    }
    
    var isFavorited: Bool = false {
        didSet {
            let image: UIImage
            let tintColor: UIColor
            if isFavorited {
                tintColor = UIColor.red
                image = unfavoriteImage
            } else {
                tintColor = UIColor.white
                image = favoriteImage
            }
            setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
            self.tintColor = tintColor
            
            if oldValue != isFavorited {
                animatedFavorite()
            }
        }
    }
    
    private func animatedFavorite() {
        let scale: CGFloat = 1.4
        transform = CGAffineTransform(scaleX: scale, y: scale)
        UIView.animate(
            withDuration: 0.75,
            delay: 0.0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
            options: [],
            animations: {
                self.transform = CGAffineTransform.identity
        },
            completion: nil
        )
    }
}
