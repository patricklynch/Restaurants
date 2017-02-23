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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.delegate = tableView
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: 4.0, left: 0.0, bottom: 4.0, right: 0.0)
        
        title = dataSource.title
        
        searchController.delegate = dataSource
        
        view.backgroundColor = Color.lightGray
        
        dataSource.load() { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let localizedTitle = NSLocalizedString("title.filters", comment: "")
        let barButtonItem = BarButtonItem(title: localizedTitle, target: self, action: #selector(showFilters))
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    // MARK: - Actions
    
    @objc private func showFilters() {
        
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
}
