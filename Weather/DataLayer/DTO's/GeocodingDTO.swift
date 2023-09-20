//
//  GeocodingDTO.swift
//  Weather
//
//  Created by Josh Franco on 9/19/23.
//

import Foundation

struct GeocodingDTO {
    /// Name of the found location
    let name: String
    /// Name of the found location in different languages. The list of names can be different for different locations.
    let localNames: [String: String]
    /// Geographical coordinates of the found location (latitude)
    let latitude: Double
    /// Geographical coordinates of the found location (longitude)
    let longitude: Double
    /// Country of the found location
    let countryCode: String
    /// State of the found location
    let state: String?
}

// MARK: - Codable

extension GeocodingDTO: Codable {
    enum CodingKeys: String, CodingKey {
        case name, state
        
        case countryCode = "country"
        case localNames = "local_names"
        case latitude = "lon"
        case longitude = "lat"
    }
}
