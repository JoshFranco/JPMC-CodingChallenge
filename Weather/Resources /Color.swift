//
//  Color.swift
//  Weather
//
//  Created by Josh Franco on 9/19/23.
//

import SwiftUI

enum InternalColor: String {
    case lightBlue = "LightBlue"
    case darkBlue = "DarkBlue"
    
    var asColor: Color {
        Color(self.rawValue)
    }
}
