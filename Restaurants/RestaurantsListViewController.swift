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
    
    let dataSource = RestaurantsListDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.delegate = tableView
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: 4.0, left: 0.0, bottom: 4.0, right: 0.0)
        
        title = dataSource.title
        
        view.backgroundColor = Color.lightGray
        
        dataSource.load() { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateToolbarItems()
    }
    
    // MARK: - Toolbar
    
    private var toolbarButtonItems: [UIBarButtonItem] = []
    
    func updateToolbarItems() {
        let itemSpacing: CGFloat = 2.0
        var allToolbarItems: [UIBarButtonItem] = []
        allToolbarItems.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        for option in SortOptions.all {
            let button = BarButtonItem(
                title: option.label,
                target: self,
                action: #selector(onToolbarItemSelected)
            )
            toolbarButtonItems.append(button)
            allToolbarItems.append(button)
            if option != SortOptions.all.last {
                let space = UIBarButtonItem(
                    barButtonSystemItem: .fixedSpace,
                    target: nil,
                    action: nil
                )
                space.width = itemSpacing
                allToolbarItems.append(space)
            }
        }
        allToolbarItems.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        setToolbarItems(allToolbarItems, animated: false)
    }
    
    // MARK: - Actions
    
    @objc private func onToolbarItemSelected(sender: UIBarButtonItem) {
        guard let index = toolbarItems?.index(of: sender) else {
            return
        }
        dataSource.sortOption = SortOptions.all[index]
    }
    
    // MARK: - UITableViewDelegate
    
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
