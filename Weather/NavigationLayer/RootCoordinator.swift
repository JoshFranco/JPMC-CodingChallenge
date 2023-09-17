//
//  RootCoordinator.swift
//  Weather
//
//  Created by Josh Franco on 9/17/23.
//

import UIKit

final class RootCoordinator {
    let id: UUID = UUID()
    var childCoordinators: [UUID : Coordinator] = [:]
    private let router: Routable
    
    init(router: Routable) {
        self.router = router
    }
}

// MARK: - Coordinator

extension RootCoordinator: Coordinator {
    func start() -> UIViewController {
        runMainFlow()
        
        return router.vcToPresent()
    }
}

// MARK: - Private

private extension RootCoordinator {
    func runMainFlow() {
        let coordinator = MainCoordinator(router: self.router)
        /// setup delegate here if we need to backtrack to the root i.e. logout/change user
        //coordinator.delegate
        let viewController = coordinate(to: coordinator)
        router.setRootModule(viewController,
                             animated: true,
                             transition: nil)
    }
}
