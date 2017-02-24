//
//  NavigationOperations.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/23/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import Foundation

/// Operation that provides an alternate function 'performNavigation' to override
/// instead of `main` so that it will always be executed on the main thread.  This
/// ensures that UI code is always on the main thread, but allows this operation to
/// be added to background queues.
class NavigationOperation: Operation {
    
    override func main() {
        DispatchQueue.main.async() {
            self.performNavigation()
        }
    }
    
    func performNavigation() {
        assertionFailure("Please implement this method in a subclass.")
    }
}

/// An operation that stays open (not complete) until `navigationDidFinish` is called.
/// This is useful for closed-loop presentations that return to the context from which
/// they were presented with some kind of return data, such as a selection of some option
/// or datum.
class OpenNavigationOperation: NavigationOperation {
    
    private let semaphore = DispatchSemaphore(value: 0)
    
    override func main() {
        DispatchQueue.main.async() {
            self.performNavigation()
        }
        let _ = semaphore.wait(timeout: DispatchTime.distantFuture)
    }
    
    final func navigationDidFinish() {
        semaphore.signal()
    }
    
    override func cancel() {
        super.cancel()
        navigationDidFinish()
    }
}
