//
//  Constants.swift
//  Weather
//
//  Created by Josh Franco on 9/17/23.
//

import Foundation

struct Constants {
    static var openWeatherAPIKey: String {
        "b2e99558282c2674b9ef37332524dd52"
    }
    
    static var currentEnvironment: APIEnvironment {
        /// If this was a production app the code below would help ensure we are connecting to the correct BE
        /// for this coding challenge we will just default to develop
//        #if DEBUG
//        return .development
//        #elseif STAGING
//        return .staging
//        #else
//        return .production
//        #endif
        
        return .development
    }
    
    static var appVersion: String? {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
}
