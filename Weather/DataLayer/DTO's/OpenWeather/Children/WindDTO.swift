//
//  File.swift
//  Weather
//
//  Created by Josh Franco on 9/17/23.
//

import Foundation

struct WindDTO {
    /// Wind speed. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour
    let speed: Double
    /// Wind direction, degrees (meteorological)
    let direction: Int
    /// Wind gust. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour
    let gust: Double
}

// MARK: - Codable

extension WindDTO: Codable {
    enum CodingKeys: String, CodingKey {
        case speed, gust
        case direction = "deg"
    }
}
