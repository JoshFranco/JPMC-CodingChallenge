//
//  File.swift
//  Weather
//
//  Created by Josh Franco on 9/17/23.
//

import Foundation

struct TemperatureDTO {
    /// Raw Temperature | Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit
    let temp: Double
    /// This temperature parameter accounts for the human perception of weather | Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit
    let realFeel: Double
    /// Minimum temperature at the moment
    let minTemp: Double
    /// Maximum temperature at the moment
    let maxTemp: Double
    
    /// Atmospheric pressure on the sea level, hPa
    let pressure: Int
    /// Humidity, %
    let humidity: Int
    /// Atmospheric pressure on the sea level, hPa
    let seaLevel: Int
    /// Atmospheric pressure on the ground level, hPa
    let groundLevel: Int
}

// MARK: - Codable

extension TemperatureDTO: Codable {
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case realFeel = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
        case seaLevel = "sea_level"
        case groundLevel = "grnd_level"
    }
}
