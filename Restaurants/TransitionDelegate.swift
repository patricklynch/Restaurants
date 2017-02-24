//
//  TransitionDelegate.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/23/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import UIKit

/// Defines an object that performs a transition animation between two view controllers
/// using configuration values provided in model`.
protocol Transition {
    var animationDuration: TimeInterval { get }
    func performTransitionIn(_ model: TransitionModel, completion: @escaping (Bool)->())
    func performTransitionOut(_ model: TransitionModel, completion: @escaping (Bool)->())
}

/// Encapsulates configuration values and references to view controllers involved in the
/// tranisition.  Intended for use by conformers to `Transition` in order to perform
/// the transition animation.
struct TransitionModel {
    let context: UIViewControllerContextTransitioning
    let transition: Transition
    let fromViewController: UIViewController
    let toViewController:UIViewController
    let presenting: Bool
    
    init(context: UIViewControllerContextTransitioning, transition: Transition) {
        self.context = context
        self.transition = transition
        guard let toViewController = context.viewController(forKey: UITransitionContextViewControllerKey.to),
            let fromViewController = context.viewController(forKey: UITransitionContextViewControllerKey.from) else {
                abort()
        }
        
        self.toViewController = toViewController
        self.fromViewController = fromViewController
        
        let modal = toViewController.presentedViewController != nil || fromViewController.presentedViewController != nil
        if let fromNav = fromViewController.navigationController , !modal {
            presenting = fromNav.viewControllers.contains(fromViewController)
        } else {
            presenting = toViewController.presentedViewController != fromViewController
        }
    }
}


/// Implementaiton of `UIViewControllerAnimatedTransitioning` designed as a reusable template
/// for many types of custom transitions that conform to `Transition`.
class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let transition: Transition
    
    init(transition: Transition) {
        self.transition = transition
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transition.animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let model = TransitionModel(
            context: transitionContext,
            transition: transition
        )
        
        let containerView = transitionContext.containerView
        
        if model.presenting {
            model.toViewController.view.frame = model.fromViewController.view.frame
            
            containerView.addSubview(model.fromViewController.view)
            containerView.addSubview(model.toViewController.view)
            
            transition.performTransitionIn(model) { completed in
                transitionContext.completeTransition( !transitionContext.transitionWasCancelled )
            }
            
        } else {
            model.fromViewController.view.frame = model.toViewController.view.frame
            
            containerView.addSubview(model.toViewController.view)
            containerView.addSubview(model.fromViewController.view)
            
            transition.performTransitionOut(model) { completed in
                transitionContext.completeTransition( !transitionContext.transitionWasCancelled )
                
                // HACK: But fixes the issue... (http://stackoverflow.com/questions/24338700/from-view-controller-disappears-using-uiviewcontrollercontexttransitioning)
                UIApplication.shared.keyWindow!.addSubview(model.toViewController.view)
            }
        }
    }
}

/// Implemention of `UIViewControllerTransitioningDelegate` using a provided `Transition` required
/// to perform a custom transition between two view controllers.  Conformanced to
/// `UINavigationControllerDelegate` is also included to support custom transitions for both
/// present and push transition styles.
class TransitionDelegate: NSObject, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    let animator: TransitionAnimator
    
    init(transition: Transition) {
        self.animator = TransitionAnimator(transition: transition)
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
    
    // MARK: - UINavigationControllerDelegate
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
}
