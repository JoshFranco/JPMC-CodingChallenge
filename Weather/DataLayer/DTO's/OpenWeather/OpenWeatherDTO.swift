//
//  OpenWeatherDTO.swift
//  Weather
//
//  Created by Josh Franco on 9/17/23.
//

import Foundation

struct OpenWeatherDTO {
    let coordinate: CoordinateDTO
    let weather: [WeatherDTO]
    let temperature: TemperatureDTO
    
    let wind: WindDTO?
    let rain: RainDTO?
    let snow: SnowDTO?
    let clouds: CloudsDTO?
    
    let system: WeatherSystemDTO
    
    /// Visibility, meter. The maximum value of the visibility is 10 km
    let visibility: Int
    /// Shift in seconds from UTC
    let timezone: Int
    /// Time of data calculation, unix, UTC
    let timeOfData: Int
    
    /// City name. Please note that built-in geocoder functionality has been deprecated
    let name: String
    /// City ID. Please note that built-in geocoder functionality has been deprecated
    let id: Int
}

// MARK: - Codable

extension OpenWeatherDTO: Codable {
    enum CodingKeys: String, CodingKey {
        case weather, visibility, wind, clouds, rain, snow, timezone, id, name
        case coordinate = "coord"
        case temperature = "main"
        case timeOfData = "dt"
        case system = "sys"
        
    }
}
