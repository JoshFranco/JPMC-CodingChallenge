//
//  HostingController.swift
//  Weather
//
//  Created by Josh Franco on 9/19/23.
//

import SwiftUI

/// Workaround for preferredStatusBarStyle to handle proper style
final class HostingController<Content: View>: UIHostingController<Content> {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        statusBarStyleOverride
    }
    
    var statusBarStyleOverride: UIStatusBarStyle
    
    init(rootView: Content, statusBarStyle: UIStatusBarStyle = .default) {
        self.statusBarStyleOverride = statusBarStyle
        super.init(rootView: rootView)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        /// only really necessary if using storyboards, but Swift requires it.
        fatalError("init(coder:) has not been implemented")
    }
}
