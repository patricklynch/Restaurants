//
//  SearchController.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/3/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import UIKit

protocol SearchControllerDelegate: class {
    var searchTerm: String? { get set }
}

class SearchController: UICollectionReusableView, UISearchBarDelegate {
    
    var delegate: SearchControllerDelegate?
    
    @IBOutlet private weak var searchBar: UISearchBar!
    
    func enableCancelButton() {
        let buttons = subviews.flatMap { $0 as? UIButton }
        for button in buttons {
            button.isEnabled = true
        }
    }
    
    override func resignFirstResponder() -> Bool {
        searchBar.showsCancelButton = false
        return searchBar.resignFirstResponder()
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchTerm = searchBar.text else {
            return
        }
        
        delegate?.searchTerm = searchTerm
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        delegate?.searchTerm = nil
        
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
}
