//
//  Presentable.swift
//  Weather
//
//  Created by Josh Franco on 9/17/23.
//

import UIKit

protocol Presentable {
    func vcToPresent() -> UIViewController
}

// MARK: - Presentable + UIViewController

extension UIViewController: Presentable {
    func vcToPresent() -> UIViewController {
        return self
    }
}
