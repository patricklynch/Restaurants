//
//  SortSelectDataSource.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/23/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import UIKit

class SortSelectDataSource: NSObject, UITableViewDataSource {
    
    let options = SortOption.all
    
    var currentSelection = SortOption.defaultCase
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SortSelectCell", for: indexPath) as! SortSelectCell
        let option = options[indexPath.row]
        cell.title = option.label
        cell.isSelected = option == currentSelection
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
}
