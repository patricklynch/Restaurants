//
//  RestaurantsListViewController.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/8/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import UIKit

class RestaurantsListViewController: UIViewController, FavoritableViewDelegate, UITableViewDelegate {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private var searchController: SearchController!
    
    let dataSource = RestaurantsListDataSource()
    
    private let oparationQueue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        dataSource.delegate = tableView
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: 4.0, left: 0.0, bottom: 4.0, right: 0.0)
        
        title = dataSource.title
        
        searchController.delegate = dataSource
        
        view.backgroundColor = Color.lightGray
        
        let localizedTitle = "Filters"
        let barButtonItem = BarButtonItem(title: localizedTitle, target: self, action: #selector(showFilters))
        navigationItem.rightBarButtonItem = barButtonItem
        
        dataSource.load() { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateInsets()
    }
    
    // MARK: - Actions
    
    @objc private func showFilters() {
        let operation = SelectSortOption(from: self, at: dataSource.sortOption)
        operation.completionBlock = { [weak self] in
            DispatchQueue.main.async {
                if let selectedSortOption = operation.selectedSortOption {
                    self?.dataSource.sortOption = selectedSortOption
                }
            }
        }
        oparationQueue.addOperation(operation)
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let _ = searchController.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let favoriteView = cell as? FavoritableView {
            favoriteView.favoriteDelegate = self
        }
    }
    
    // MARK: - FavoritableViewDelegate
    
    func cellDidToggleFavorite(_ view: FavoritableView) {
        guard let cell = view as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell),
            let restaurant = dataSource.items[indexPath.row] as? Restaurant else {
                return
        }
       
        if !restaurant.isFavorited() {
            restaurant.favorite()
        } else {
            restaurant.unfavorite()
        }
    }
    
    // MARK: - Keyboard (searching)
    
    private func updateInsets() {
        let bottomInset: CGFloat
        if let keyboardInset = keyboardInset {
            bottomInset = keyboardInset.bottom
        } else {
            bottomInset = 0.0
        }
        let insets = UIEdgeInsets(
            top: tableView.contentInset.top,
            left: tableView.contentInset.left,
            bottom: bottomInset,
            right: tableView.contentInset.right
        )
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    var keyboardInset: UIEdgeInsets? {
        didSet {
            view.setNeedsLayout()
        }
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else {
                return
        }
        keyboardInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        keyboardInset = nil
    }
}
