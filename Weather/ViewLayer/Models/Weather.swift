//
//  Weather.swift
//  Weather
//
//  Created by Josh Franco on 9/19/23.
//

import Foundation

struct Weather: Codable {
    let rawTemp: Double
    let tempHigh: Double
    let tempLow: Double
    
    let location: String
    let condition: String
    let iconId: String
    
    var iconUrl: URL? {
        URL(string: "https://openweathermap.org/img/wn/\(iconId)@2x.png")
    }
}

// MARK: - Convenience Initializers

extension Weather {
    init(weatherDTO: OpenWeatherDTO, location: GeocodingDTO) {
        self.rawTemp = weatherDTO.temperature.temp
        self.tempHigh = weatherDTO.temperature.maxTemp
        self.tempLow = weatherDTO.temperature.minTemp
        
        self.location = location.name
        self.condition = weatherDTO.weather.first?.description ?? ""
        self.iconId = weatherDTO.weather.first?.iconId ?? "10d"
    }
}

// MARK: - Identifiable & Hashable

extension Weather: Identifiable, Hashable {
    var id: Int {
        self.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawTemp.hashValue)
        hasher.combine(iconId.hashValue)
        hasher.combine(location.hashValue)
    }
}
