//
//  RestaurantsListDataSource.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/9/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import UIKit

class RestaurantsListDataSource: NSObject, Sortable, SearchControllerDelegate, SelfUpdatingDataSource, UITableViewDataSource {
    
    /// To prevent locking the main thread while sorting large data sets:
    private let backgroundQueue = DispatchQueue(label: "com.lynchdev.Restaurants.backgroundQueue")
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantListCell", for: indexPath)
        decorate(cell: cell, at: indexPath)
        return cell
    }
    
    // MARK: - SelfUpdatingDataSource
    
    var delegate: SelfUpdatingDataSourceDelegate?
    
    func decorate(cell: UIView, at indexPath: IndexPath) {
        let cell = cell as! RestaurantListCell
        let restaurant = items[indexPath.row] as! Restaurant
        cell.viewData = RestaurantListCell.ViewModel(
            title: restaurant.name,
            status: restaurant.status.description,
            locationDescription: restaurant.locationDescription,
            averageRating: restaurant.averageRating,
            priceDescription: restaurant.priceDescription,
            deliveryDescription: restaurant.deliveryDescription,
            imageUrl: restaurant.imageUrl
        )
        cell.isFavorited = restaurant.isFavorited()
    }
    
    // MARK: - SearchControllerDelegate
    
    var searchTerm: String? {
        didSet {
            sortAndFilterItems()
        }
    }
    
    // MARK: - Sortable
    
    var sortOption: SortOptions? = .deliveryCosts {
        didSet {
            items = NSOrderedSet(array: [])
            
            DispatchQueue.main.asyncAfter(delay: 0.25) {
                self.sortAndFilterItems()
            }
        }
    }
    
    private(set) var unsortedItems = NSOrderedSet() {
        didSet {
            sortAndFilterItems()
        }
    }
    
    private func sortAndFilterItems() {
        guard let sortOption = sortOption else {
            items = unsortedItems
            return
        }
        
        let restaurants = unsortedItems.flatMap { $0 as? Restaurant }
        backgroundQueue.async { [weak self] in
            
            // Fitler
            let filteredResults: [Restaurant]
            if let searchTerm = self?.searchTerm, searchTerm.containsNonSpaceCharacter() {
                let sanitzedTerm = searchTerm.lowercased()
                filteredResults = restaurants.filter { $0.name.matches(sanitzedTerm) }
            } else {
                filteredResults = restaurants
            }
            
            // Sort
            let sortedResults: [Restaurant]
            if let sorter = sortOption.sorter {
                sortedResults = sorter.sorted(from: filteredResults)
            } else {
                sortedResults = filteredResults
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.items = NSOrderedSet(array: sortedResults)
            }
        }
    }
}

fileprivate extension String {
    
    func matches(_ searchTerm: String) -> Bool {
        if searchTerm.characters.count == 1 {
            let words = lowercased().components(separatedBy: " ")
            return words.contains { $0.characters.first == searchTerm.characters.first }
        } else {
            return lowercased().contains(searchTerm)
        }
    }
    
    func containsNonSpaceCharacter() -> Bool {
        let space = " ".characters.first!
        return !characters.filter { $0 != space }.isEmpty
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
