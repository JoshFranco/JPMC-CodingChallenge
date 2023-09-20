//
//  PersistencyManager.swift
//  Weather
//
//  Created by Josh Franco on 9/20/23.
//

import Foundation

class PersistencyManager {
    static var shared = PersistencyManager()
    
    private let defaults = UserDefaults.standard
    private let weatherKey = "local_weather"
    
    private init() {}
    
    func saveWeather(_ weather: Weather) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(weather) {
            defaults.set(encoded, forKey: weatherKey)
        }
    }
    
    func loadWeather() -> Weather? {
        guard let savedWeather = defaults.object(forKey: weatherKey) as? Data else { return nil }
        
        let decoder = JSONDecoder()
        return try? decoder.decode(Weather.self, from: savedWeather)
    }
}
