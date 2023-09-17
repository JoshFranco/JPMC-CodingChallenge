//
//  RootRouter.swift
//  Weather
//
//  Created by Josh Franco on 9/17/23.
//

import UIKit

final class RootRouter: NSObject {
    private var navigationController: UINavigationController
    private var transition: UIViewControllerAnimatedTransitioning?
    private var backEnabled: Bool
    
    init(navigationController: UINavigationController, backEnabled: Bool = true) {
        self.navigationController = navigationController
        self.backEnabled = backEnabled
    }
}

// MARK: - Presentable

extension RootRouter: Presentable {
    func vcToPresent() -> UIViewController {
        navigationController
    }
}

// MARK: - Routable

extension RootRouter: Routable {
    func present(_ module: Presentable, animated: Bool) {
        let controller = module.vcToPresent()
        navigationController.present(controller,
                                     animated: animated,
                                     completion: nil)
    }
    
    func dismissModule(animated: Bool, completion: (() -> Void)?) {
        navigationController.dismiss(animated: animated,
                                     completion: completion)
    }
    
    func push(_ module: Presentable,
              animated: Bool,
              hideBottomBar: Bool,
              completion: (() -> Void)?) {
        let controller = module.vcToPresent()
        guard !(controller is UINavigationController) else {
            assertionFailure("Cannot push UINavigationController")
            return
        }
        
        
        controller.hidesBottomBarWhenPushed = hideBottomBar

        if backEnabled {
            navigationController.pushViewController(controller, animated: animated)
        } else {
            navigationController.setViewControllers([controller], animated: animated)
        }
    }
    
    func push(viewControllers: [UIViewController],
              animated: Bool = true,
              hideBottomBar: Bool = false,
              completion: (() -> Void)? = nil) {
        guard viewControllers.filter({ $0 is UINavigationController }).isEmpty else {
            assertionFailure("Cannot push UINavigationController")
            return
        }

        for viewController in viewControllers {
            viewController.hidesBottomBarWhenPushed = hideBottomBar
        }
        
        var currentViewControllers = navigationController.viewControllers
        currentViewControllers.append(contentsOf: viewControllers)
        navigationController.setViewControllers(currentViewControllers, animated: animated)
    }
    
    func popModule(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }
    
    func popToRootModule(animated: Bool) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    func setRootModule(_ module: Presentable,
                       animated: Bool,
                       transition: UIViewControllerAnimatedTransitioning?,
                       hideBar: Bool) {
        let controller = module.vcToPresent()
        
        // Set desired transition
        // If transition set, set navigationController delegate to handle transition
        self.transition = transition
        navigationController.delegate = transition != nil ? self : nil
        
        navigationController.setViewControllers([controller], animated: animated)
        navigationController.navigationBar.isHidden = hideBar
        
        // IMPORTANT: After transition, reset delegate to nil
        // This allows default edge drags and such to work properly
        navigationController.delegate = nil
    }
    
    func setRootModule(viewControllers: [UIViewController],
                       animated: Bool = false,
                       transition: UIViewControllerAnimatedTransitioning? = nil,
                       hideBar: Bool = true) {
        // Set desired transition
        // If transition set, set navigationController delegate to handle transition
        self.transition = transition
        navigationController.delegate = transition != nil ? self : nil
        
        navigationController.setViewControllers(viewControllers, animated: animated)
        navigationController.navigationBar.isHidden = hideBar
        
        // IMPORTANT: After transition, reset delegate to nil
        // This allows default edge drags and such to work properly
        navigationController.delegate = nil
    }
}

// MARK: - UINavigationControllerDelegate

extension RootRouter: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.transition
    }
}
