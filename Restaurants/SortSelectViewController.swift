//
//  SortSelectViewController.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/23/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import UIKit

protocol SortSelectionDelegate {
    func didSelect(sortOption: SortOption)
    func didCancel()
}

class SortSelectViewController: UIViewController, UITableViewDelegate, LightboxTransitionViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var tableViewHeight: NSLayoutConstraint!
    
    private let dataSource = SortSelectDataSource()
    
    var currentSelection: SortOption {
        set {
            dataSource.currentSelection = newValue
        } get {
            return dataSource.currentSelection
        }
    }
    var delegate: SortSelectionDelegate?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.layer.cornerRadius = 5.0
        tableView.delegate = self
        tableView.dataSource = dataSource
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableViewHeight.constant = CGFloat(tableView.numberOfRows(inSection: 0)) * 44.0 // tableView.rowHeight
        tableView.layoutIfNeeded()
    }
    
    // MARK: - Actions
    
    @IBAction private func onBackgroundTapped() {
        delegate?.didCancel()
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedOption = dataSource.options[indexPath.row]
        currentSelection = selectedOption
        tableView.reloadData()
        delegate?.didSelect(sortOption: selectedOption)
    }
    
    // MARK: - LightboxTransitionViewController
    
    @IBOutlet weak var backgroundView: UIView!
    
    var contentViews: [UIView] {
        return [tableView]
    }
}
