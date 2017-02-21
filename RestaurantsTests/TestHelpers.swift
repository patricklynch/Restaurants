//
//  TestHelpers.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/22/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import Foundation
import SwiftyJSON

extension JSON {
    
    /// Lods and parses a file from the test bundle
    static func fromBundle(named filename: String) -> JSON? {
        guard let url = Bundle(for: RestaurantTests.self).resourceURL?.appendingPathComponent(filename),
            let data = try? Data(contentsOf: url, options: []) else {
                return nil
        }
        return JSON(data: data)
    }
}
