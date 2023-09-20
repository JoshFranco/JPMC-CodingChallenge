//
//  File.swift
//  Weather
//
//  Created by Josh Franco on 9/17/23.
//

import Foundation

struct WeatherDTO {
    /// Internal parameter
    let id: Int
    /// Internal parameter
    let iconId: String
    
    /// Group of weather parameters (Rain, Snow, Clouds etc.)
    let main: String
    /// Weather condition within the group
    let description: String
}

// MARK: - Codable

extension WeatherDTO: Codable {
    enum CodingKeys: String, CodingKey {
        case id, main, description
        case iconId = "icon"
    }
}
