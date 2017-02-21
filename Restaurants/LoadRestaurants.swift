//
//  LoadRestaurants.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/22/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import Foundation
import SwiftyJSON

/// Loads restaursnts models from disk and makes them available in
/// `results`.  If an error is encountered, `results` will
/// be `nil` and `error` will be defined.
class LoadRestaurants: Operation {
    
    private(set) var results: [Restaurant]?
    private(set) var error: NSError?
    
    // Mockable with `var`
    lazy var bundle: Bundle = {
        return Bundle(for: type(of: self))
    }()
    
    // Mockable with `var`
    var filename: String = "sample.json"
    
    override func main() {
        guard let url = bundle.resourceURL?.appendingPathComponent(filename) else {
            error = NSError(domain: "com.lynchdev.error", code: 1, userInfo: [:])
            return
        }
        do {
            let data = try Data(contentsOf: url, options: [])
            let json = JSON(data: data)
            results = json["restaurants"].arrayValue.flatMap { Restaurant(json: $0) }
        } catch {
            self.error = error as NSError
        }
    }
}
