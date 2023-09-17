//
//  Router.swift
//  Weather
//
//  Created by Josh Franco on 9/17/23.
//

import UIKit

protocol Routable: Presentable {
    func present(_ module: Presentable, animated: Bool)
    func dismissModule(animated: Bool, completion: (() -> Void)?)
    func popModule(animated: Bool)
    func popToRootModule(animated: Bool)
    
    func push(_ module: Presentable,
              animated: Bool,
              hideBottomBar: Bool,
              completion: (() -> Void)?)
    func push(viewControllers: [UIViewController],
              animated: Bool,
              hideBottomBar: Bool,
              completion: (() -> Void)?)
    func setRootModule(_ module: Presentable,
                       animated: Bool,
                       transition: UIViewControllerAnimatedTransitioning?,
                       hideBar: Bool)
    func setRootModule(viewControllers: [UIViewController],
                       animated: Bool,
                       transition: UIViewControllerAnimatedTransitioning?,
                       hideBar: Bool)
}

// MARK: - Default Implementation

/// Holds the same method signatures with default values for our most common use cases
extension Routable {
    func present(_ module: Presentable, animated: Bool = true) {
        present(module, animated: animated)
    }
    
    func dismissModule(animated: Bool = true, completion: (() -> Void)? = nil) {
        dismissModule(animated: animated, completion: completion)
    }
    
    func push(
        _ module: Presentable,
        animated: Bool = true,
        hideBottomBar: Bool = false,
        completion: (() -> Void)? = nil
    ) {
        push(module, animated: animated, hideBottomBar: hideBottomBar, completion: completion)
    }
    
    func push(
        viewControllers: [UIViewController],
        animated: Bool = true,
        hideBottomBar: Bool = false,
        completion: (() -> Void)? = nil
    ) {
        push(viewControllers: viewControllers, animated: animated, hideBottomBar: hideBottomBar, completion: completion)
    }
    
    func popModule(animated: Bool = true) {
        popModule(animated: animated)
    }
    
    func popToRootModule(animated: Bool = true) {
        popToRootModule(animated: animated)
    }
    
    func setRootModule(
        _ module: Presentable,
        animated: Bool = false,
        transition: UIViewControllerAnimatedTransitioning? = nil,
        hideBar: Bool = true
    ) {
        setRootModule(module, animated: animated, transition: transition, hideBar: hideBar)
    }
    
    func setRootModule(
        viewControllers: [UIViewController],
        animated: Bool = false,
        transition: UIViewControllerAnimatedTransitioning? = nil,
        hideBar: Bool = true
    ) {
        setRootModule(viewControllers: viewControllers, animated: animated, transition: transition, hideBar: hideBar)
    }
}
