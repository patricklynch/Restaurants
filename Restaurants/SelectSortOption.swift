//
//  SelectSortOption.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/23/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import UIKit

class SelectSortOption: OpenNavigationOperation, SortSelectionDelegate {
    
    let transitionDelegate = TransitionDelegate(transition: LightboxTransition())
    
    private weak var originViewController: UIViewController?
    let initialSelectedSortOption: SortOption
    
    var selectedSortOption: SortOption?
    
    init(from originViewController: UIViewController, at sortOption: SortOption) {
        self.originViewController = originViewController
        self.initialSelectedSortOption = sortOption
    }
    
    override func performNavigation() {
        guard let originViewController = originViewController else {
            cancel()
            navigationDidFinish()
            return
        }
        
        let viewController: SortSelectViewController = UIViewController.fromStoryboard(named: "Main")
        viewController.transitioningDelegate = transitionDelegate
        viewController.delegate = self
        viewController.currentSelection = initialSelectedSortOption
        viewController.modalPresentationStyle = .custom
        originViewController.present(viewController, animated: true, completion: nil)
    }
    
    // MARK: - SortSelectionDelegate
    
    func didSelect(sortOption: SortOption) {
        self.selectedSortOption = sortOption
        originViewController?.dismiss(animated: true) { [weak self] in
            self?.navigationDidFinish()
        }
    }
    
    func didCancel(){
        originViewController?.dismiss(animated: true, completion: nil)
        navigationDidFinish()
    }
}
