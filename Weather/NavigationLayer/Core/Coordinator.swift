//
//  Coordinator.swift
//  Weather
//
//  Created by Josh Franco on 9/17/23.
//

import UIKit

protocol Coordinator: AnyObject {
    /// Unique id to store and identify child `Coordinators`.
    var id: UUID { get }
    
    /// List of Child `Coordinators`.
    ///
    /// Here is where all the references are stored for all `childCoordinators`, so they are not deallocated before they need to be.
    /// The parent `Coordinator` is in charge of deallocating all the `childCoordinators` when the time is right.
    ///
    /// We use a dictionary for easy lookup and removal.
    var childCoordinators: [UUID: Coordinator] { get set }
    
    /// Instantiate the initial `UIViewController` for this `Coordinator` flow.
    ///
    /// `Coordinator` builds and injects all dependencies and returns a `UIViewController`.
    ///
    /// - Returns: Initial `UIViewController` for this `Coordinator`.
    func start() -> UIViewController
    
    /// Coordinate to the next `Coordinator` in the navigation flow.
    ///
    /// - Parameter coordinator: The next child `Coordinator` to coordinate to.
    ///
    /// When coordinating to a child `Coordinator`, every `Coordinator` must add the child `Coordinator`
    /// to its `childCoordinators` and start the child `Coordinator` to build and return the child's initial `UIViewController`.
    ///
    /// - Returns: Initial `UIViewController` for given `coordinator`
    ///
    /// - Important: A default implementation is defined for this function.
    func coordinate(to coordinator: Coordinator) -> UIViewController
    
    /// Removes a `Coordinator` from `childCoordinators`
    ///
    /// - Parameter id: `UUID` of the child `Coordinator` to remove.
    ///
    /// Every `Coordinator` must remove child `Coordinators` when they are not needed anymore.
    ///
    /// - Important: A default implementation is defined for this function.
    func removeCoordinator(withId id: UUID)
}

// MARK: - Default Implementation

extension Coordinator {
    func coordinate(to coordinator: Coordinator) -> UIViewController {
        // Add to childCoordinators
        childCoordinators[coordinator.id] = coordinator
        
        // Build and return initial UIViewController
        return coordinator.start()
    }
    
    func removeCoordinator(withId id: UUID) {
        childCoordinators.removeValue(forKey: id)
    }
}
