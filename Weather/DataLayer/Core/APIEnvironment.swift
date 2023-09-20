//
//  APIEnvironment.swift
//  Weather
//
//  Created by Josh Franco on 9/17/23.
//

import Foundation

enum APIEnvironment {
    case development
    case staging
    case production

    var baseURL: String {
        switch self {
        case .development:
            return "https://api.openweathermap.org"
        case .staging:
            return "staging.example.com"
        case .production:
            return "production.example.com"
        }
    }
}
