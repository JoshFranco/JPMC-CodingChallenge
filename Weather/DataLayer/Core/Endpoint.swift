//
//  Endpoint.swift
//  Weather
//
//  Created by Josh Franco on 9/17/23.
//

import Foundation

// TODO: - We can enhance this enum to build a URL, if we do that we can input the query parameters as enum parameters 
enum Endpoint {
    /// Example - https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
    case openWeather
    /// Example - http://api.openweathermap.org/geo/1.0/direct?q=London&limit=5&appid={API key}
    case geocoding
    /// Example - http://api.openweathermap.org/geo/1.0/reverse?lat=51.5098&lon=-0.1180&limit=5&appid={API key}
    case reverseGeocoding

    var path: String {
        switch self {
        case .openWeather:
            return "/data/2.5/weather"
        case .geocoding:
            return "/geo/1.0/direct"
        case .reverseGeocoding:
            return "/geo/1.0/reverse"
        }
    }

    var httpMethod: HttpMethod {
        switch self {
        default:
            return .get
        }
    }
}
