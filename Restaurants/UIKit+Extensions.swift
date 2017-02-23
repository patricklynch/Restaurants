//
//  UIKit+Extensions.swift
//  Recipes
//
//  Created by Patrick Lynch on .
//  Copyright © 2017 lynchdev. All rights reserved.
//

import UIKit

import SDWebImage

extension UIImageView {
    
    /// Loads the image at `imageUrl` from one of the available caches or
    /// over the network and plays a simple `alpha` animation if this was
    /// the first time the image has been loaded, i.e. it was not cached
    func fadeInImage(at imageUrl: URL, completion: (()->())? = nil) {
        sd_setImage(with: imageUrl) { image, error, cacheType, url in
            let animations = {
                if image != nil {
                    self.alpha = 1.0
                } else {
                    self.alpha = 0.0
                }
            }
            if cacheType == .none {
                self.image = image
                self.alpha = 0.0
                UIView.animate(withDuration: 0.35, animations: animations)
            } else {
                animations()
            }
            completion?()
        }
    }
}
