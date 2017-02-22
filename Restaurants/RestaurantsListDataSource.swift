//
//  RestaurantsListDataSource.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/9/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import UIKit

class RestaurantsListDataSource: NSObject, Sortable, SelfUpdatingDataSource, UITableViewDataSource {
    
    /// To prevent locking the main thread while sorting large data sets:
    private let sortQueue = DispatchQueue(label: "com.lynchdev.Restaurants.sortQueue")
    
    private(set) var items = NSOrderedSet(){
        didSet {
            if items.count != oldValue.count {
                delegate?.dataSource(self, didUpdateItemsFromOldValue: oldValue, toNewValue: items, section: 0)
            } else {
                delegate?.dataSource(self, redecorateItemsIn: 0)
            }
        }
    }
    
    let title: String = NSLocalizedString("title.restaurants", comment: "")
    
    private lazy var distanceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_DE")
        return formatter
    }()
    
    private lazy var priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_DE")
        return formatter
    }()
    
    // Background queue for loading restaurants
    let loadingQueue = OperationQueue()
    
    func load(completion: @escaping ()->()) {
        let operation = LoadRestaurants()
        operation.completionBlock = { [weak self] in
            DispatchQueue.main.async {
                if let error = operation.error {
                    print("Error loading restaurants: \(error)")
                } else {
                    self?.unsortedItems = NSOrderedSet(array: operation.results ?? [])
                }
                completion()
            }
        }
        loadingQueue.addOperation(operation)
    }
    
    // MARK: - UITableViewModelSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = RestaurantListCell.defaultReuseIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        decorate(cell: cell, at: indexPath)
        return cell
    }
    
    // MARK: - SelfUpdatingDataSource
    
    var delegate: SelfUpdatingDataSourceDelegate?
    
    func decorate(cell: UIView, at indexPath: IndexPath) {
        let restaurant = items[indexPath.row] as! Restaurant
        let cell = cell as! RestaurantListCell
        let distance = Float(restaurant.sortingValues.distance) / 1000.0
        let deliveryCost = Float(restaurant.sortingValues.deliveryCosts) / 100.0
        cell.viewData = RestaurantListCell.ViewModel(
            title: restaurant.name,
            status: restaurant.status.text,
            distance: distanceFormatter.string(from: NSNumber(value: distance)) ?? "",
            averageRating: restaurant.averageRating,
            priceRating: restaurant.priceRating,
            deliveryCost: priceFormatter.string(from: NSNumber(value: deliveryCost)) ?? "",
            imageUrl: URL(string: "http://www.google.com")! // restaurant.imageUrl
        )
    }
    
    // MARK: - Sortable
    
    var sortOption: SortOptions? = .bestMatch {
        didSet {
            items = NSOrderedSet(array: [])
            
            DispatchQueue.main.asyncAfter(delay: 0.25) {
                self.updateSortedItems()
            }
        }
    }
    
    private(set) var unsortedItems = NSOrderedSet() {
        didSet {
            updateSortedItems()
        }
    }
    
    private func updateSortedItems() {
        guard let sortOption = sortOption else {
            items = unsortedItems
            return
        }
        
        let options = unsortedItems.flatMap { $0 as? Restaurant }
        sortQueue.async {
            let results = options.sorted {
                switch sortOption {
                case .bestMatch:
                    return $0.sortingValues.bestMatch < $1.sortingValues.bestMatch
                case .newest:
                    return $0.sortingValues.newest < $1.sortingValues.newest
                case .ratingAverage:
                    return $0.sortingValues.ratingAverage < $1.sortingValues.ratingAverage
                case .distance:
                    return $0.sortingValues.distance < $1.sortingValues.distance
                case .popularity:
                    return $0.sortingValues.popularity < $1.sortingValues.popularity
                case .averageProductPrice:
                    return $0.sortingValues.averageProductPrice < $1.sortingValues.averageProductPrice
                case .deliveryCosts:
                    return $0.sortingValues.deliveryCosts < $1.sortingValues.deliveryCosts
                case .minCost:
                    return $0.sortingValues.minCost < $1.sortingValues.minCost
                }
            }
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.items = NSOrderedSet(array: results)
            }
        }
    }
}

extension DispatchQueue {
    
    func asyncAfter(delay: TimeInterval, closure: @escaping ()->()) {
        let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        asyncAfter(deadline: dispatchTime) {
            closure()
        }
    }
}
