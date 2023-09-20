//
//  RainDTO.swift
//  Weather
//
//  Created by Josh Franco on 9/17/23.
//

import Foundation

struct RainDTO {
    let oneHourRainVolume: String?
    let threeHourRainVolume: String?
}

// MARK: - Codable

extension RainDTO: Codable {
    enum CodingKeys: String, CodingKey {
        case oneHourRainVolume = "1h"
        case threeHourRainVolume = "3h"
    }
}
