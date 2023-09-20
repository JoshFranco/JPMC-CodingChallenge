//
//  SnowDTO.swift
//  Weather
//
//  Created by Josh Franco on 9/17/23.
//

import Foundation

struct SnowDTO {
    let oneHourSnowVolume: String?
    let threeHourSnowVolume: String?
}

// MARK: - Codable

extension SnowDTO: Codable {
    enum CodingKeys: String, CodingKey {
        case oneHourSnowVolume = "1h"
        case threeHourSnowVolume = "3h"
    }
}
