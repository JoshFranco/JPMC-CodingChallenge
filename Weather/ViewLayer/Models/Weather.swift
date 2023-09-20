//
//  Weather.swift
//  Weather
//
//  Created by Josh Franco on 9/19/23.
//

import Foundation

struct Weather {
    let rawTemp: Int
    let tempHigh: Int
    let tempLow: Int
    
    let location: String
    let condition: String
    let iconId: String
    
    var iconUrl: URL? {
        URL(string: "https://openweathermap.org/img/wn/\(iconId)@2x.png")
    }
}
