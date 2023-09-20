//
//  File.swift
//  Weather
//
//  Created by Josh Franco on 9/17/23.
//

import Foundation

struct CoordinateDTO {
    /// Geographical coordinates of the found location (latitude)
    let latitude: Double
    /// Geographical coordinates of the found location (longitude)
    let longitude: Double
}

// MARK: - Codable

extension CoordinateDTO: Codable {
    enum CodingKeys: String, CodingKey {
        case latitude = "lon"
        case longitude = "lat"
    }
}
