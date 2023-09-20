//
//  CloudsDTO.swift
//  Weather
//
//  Created by Josh Franco on 9/17/23.
//

import Foundation

struct CloudsDTO {
    /// Cloudiness, %
    let cloudinessPercentage: Int
}

// MARK: - Codable

extension CloudsDTO: Codable {
    enum CodingKeys: String, CodingKey {
        case cloudinessPercentage = "all"
    }
}
