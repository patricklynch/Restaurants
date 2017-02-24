//
//  SortSelectDataSource.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/23/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import UIKit

class SortSelectDataSource: NSObject, UITableViewDataSource {
    
    let options = SortOptions.all
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SortSelectCell", for: indexPath) as! SortSelectCell
        cell.title = options[indexPath.row].label
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
}
