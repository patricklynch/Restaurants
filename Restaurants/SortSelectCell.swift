//
//  SortSelectCell.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/23/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import UIKit

class SortSelectCell: UITableViewCell {
    
    @IBOutlet private weak var label: UILabel!
    
    var title: String? {
        didSet {
            label.text = title
        }
    }
    
    override var isSelected: Bool {
        didSet {
            accessoryType = isSelected ? .checkmark : .none
        }
    }
}
