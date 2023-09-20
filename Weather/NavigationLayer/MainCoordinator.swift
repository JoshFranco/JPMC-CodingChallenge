//
//  MainCoordinator.swift
//  Weather
//
//  Created by Josh Franco on 9/17/23.
//

import UIKit
import SwiftUI

final class MainCoordinator {
    let id: UUID = UUID()
    var childCoordinators: [UUID: Coordinator] = [:]
    let router: Routable
    
    init(router: Routable) {
        self.router = router
    }
}

// MARK: - Coordinator

extension MainCoordinator: Coordinator {
    func start() -> UIViewController {
        let view = WeatherListView()
        return HostingController(rootView: view)
    }
}
