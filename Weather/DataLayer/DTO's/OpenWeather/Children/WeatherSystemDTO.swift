//
//  WeatherSystemDTO.swift
//  Weather
//
//  Created by Josh Franco on 9/17/23.
//

import Foundation

struct WeatherSystemDTO {    
    /// Country code (GB, JP etc.)
    let countryCode: String
    /// Sunrise time, unix, UTC
    let sunrise: Int
    /// Sunset time, unix, UTC
    let sunset: Int
}

// MARK: - Codable

extension WeatherSystemDTO: Codable {
    enum CodingKeys: String, CodingKey {
        case sunrise, sunset
        case countryCode = "country"
    }
}
