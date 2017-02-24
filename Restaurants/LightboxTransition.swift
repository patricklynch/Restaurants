//
//  LightboxTransition.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/23/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import UIKit

/// Defines the properties of a view controller necessary to perform the animations
/// implemented by `LightboxTransition`.
protocol LightboxTransitionViewController {
    var backgroundView: UIView! { get }
    var contentViews: [UIView] { get }
}

/// A custom transition that animates a background screen behind some foreground
/// content.  Works with either push of present transitions.
class LightboxTransition: Transition {
    
    let animationDuration: TimeInterval = 0.25
    let animationScale: CGFloat = 0.9
    
    func performTransitionIn(_ model: TransitionModel, completion: @escaping (Bool)->()) {
        guard let viewController = model.toViewController as? LightboxTransitionViewController else {
            completion(false)
            return
        }
        
        viewController.backgroundView.alpha = 0.0
        for view in viewController.contentViews {
            view.alpha = 0.0
            view.transform = CGAffineTransform(scaleX: animationScale, y: animationScale)
        }
        
        UIView.animate(
            withDuration: animationDuration,
            delay: 0.0,
            options: [.curveEaseOut],
            animations: {
                viewController.backgroundView.alpha = 1.0
            },
            completion: { finished in
                var delay: TimeInterval = 0.0
                for view in viewController.contentViews {
                    UIView.animate(
                        withDuration: 0.5,
                        delay: delay,
                        usingSpringWithDamping: 0.5,
                        initialSpringVelocity: 0.5,
                        options: [],
                        animations: {
                            view.transform = CGAffineTransform.identity
                            view.alpha = 1.0
                        },
                        completion: { finished in
                            if view == viewController.contentViews.last {
                                completion(finished)
                            }
                        }
                    )
                    delay += 0.1
                }
            }
        )
    }
    
    func performTransitionOut(_ model: TransitionModel, completion: @escaping (Bool)->()) {
        guard let viewController = model.fromViewController as? LightboxTransitionViewController else {
            completion(false)
            return
        }
        
        viewController.backgroundView.alpha = 1.0
        for view in viewController.contentViews {
            view.transform = CGAffineTransform.identity
            view.alpha = 1.0
        }
        
        let initialDelay = 0.1
        var delay: TimeInterval = initialDelay
        for view in viewController.contentViews.reversed() {
            UIView.animate(
                withDuration: 0.2,
                delay: delay,
                options: [.curveEaseOut],
                animations: {
                    view.alpha = 0.0
                    view.transform = CGAffineTransform(scaleX: self.animationScale, y: self.animationScale)
                },
                completion: nil
            )
            delay += 0.1
        }
        UIView.animate(
            withDuration: self.animationDuration,
            delay: initialDelay + TimeInterval(viewController.contentViews.count) * 0.1,
            options: [.curveEaseOut],
            animations: {
                viewController.backgroundView.alpha = 0.0
            },
            completion: completion
        )
    }
}
