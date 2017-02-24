//
//  UIKit+Extensions.swift
//  Recipes
//
//  Created by Patrick Lynch on .
//  Copyright © 2017 lynchdev. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    /// Returns the name of this class as a string
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

import SDWebImage

extension UIImageView {
    
    /// Loads the image at `imageUrl` from one of the available caches or
    /// over the network and plays a simple `alpha` animation if this was
    /// the first time the image has been loaded, i.e. it was not cached
    func fadeInImage(at imageUrl: URL, completion: (()->())? = nil) {
        sd_setImage(with: imageUrl) { image, error, cacheType, url in
            if cacheType == .none {
                self.image = image
                self.alpha = 0.0
                UIView.animate(withDuration: 0.35) {
                    self.alpha = 1.0
                }
            } else {
                self.alpha = 1.0
            }
            completion?()
        }
    }
}

/// Returns the name of a class by itself (without any package name)
func string(fromClass aClass: AnyClass) -> String {
    var className = NSStringFromClass(aClass)
    let components = className.components(separatedBy: ".")
    if let last = components.last, last.characters.count > 0 {
        className = last
    }
    return className as String
}

extension UIViewController {
    
    /// Loads a view controller from a storyboard named `storyboardName` with identifier `identifier`.
    /// If either parameter are ommitted, the name of the generic type `T` as a string will be used for both.
    static func fromStoryboard<T: UIViewController>(named name: String? = nil, identifier: String? = nil) -> T {
        let storyboardName = name ?? string(fromClass:T.self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil )
        let viewControllerIdentifier = identifier ?? string(fromClass:T.self)
        return storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier ) as! T
    }
    
    /// Loads the iniitial view conroller from a storyboard named `storybaordName`.
    /// If it is ommitted, the name of the generic type `T` as a string will be used instead.
    static func initialFromStoryboard<T: UIViewController>(named name: String? = nil ) -> T {
        let storyboardName = name ?? string(fromClass:T.self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil )
        return storyboard.instantiateInitialViewController() as! T
    }
}
