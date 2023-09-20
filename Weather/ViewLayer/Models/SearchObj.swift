//
//  SearchObj.swift
//  Weather
//
//  Created by Josh Franco on 9/20/23.
//

import Foundation

struct SearchObj {
    let name: String
    let lat: Double
    let lon: Double
    let countryCode: String
    let state: String?
}
// MARK: - Convenience Initializers

extension SearchObj {
    init(geocoding: GeocodingDTO) {
        self.name = geocoding.name
        self.lat = geocoding.latitude
        self.lon = geocoding.longitude
        self.countryCode = geocoding.countryCode
        self.state = geocoding.state
    }
}

// MARK: - Identifiable & Hashable

extension SearchObj: Identifiable, Hashable {
    var id: Int {
        self.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(lat)
        hasher.combine(lon)
    }
}
