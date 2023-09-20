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
        let viewModel = WeatherViewModel()
        viewModel.coordinator = self
        let view = WeatherListView(viewModel: viewModel)
        return HostingController(rootView: view)
    }
}

// MARK: - WeatherListViewViewModelCoordinatorDelegate

extension MainCoordinator: WeatherViewModelCoordinatorDelegate {
    func weatherListDidTapInputButton() {
        showWeatherInputView()
    }
}

// MARK: - Private

private extension MainCoordinator {
    func showWeatherInputView() {
        let viewModel = InputViewModel()
        let view = WeatherInputView(viewModel: viewModel)
        let viewController = HostingController(rootView: view)
        router.present(viewController, animated: true)
    }
}
