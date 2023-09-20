//
//  WeatherListItemView.swift
//  Weather
//
//  Created by Josh Franco on 9/19/23.
//

import SwiftUI
import Kingfisher

struct WeatherListItemView: View {
    private let weather: Weather
    private var backgroundGradient: LinearGradient {
        LinearGradient(colors: [InternalColor.lightBlue.asColor,
                                InternalColor.darkBlue.asColor],
                       startPoint: .bottom,
                       endPoint: .topTrailing)
    }
    
    init(_ weather: Weather) {
        self.weather = weather
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(weather.rawTemp)°")
                .font(.title)
                .foregroundColor(.white)
                .scenePadding(.vertical)
            
            HStack {
                Text("H:\(weather.tempHigh)°")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text("H:\(weather.tempLow)°")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            HStack {
                Text(weather.location)
                    .font(.body)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text(weather.condition)
                    .font(.caption)
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(backgroundGradient)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .overlay(alignment: .topTrailing) {
            KFImage.url(weather.iconUrl)
                .frame(width: 50, height: 50)
                .padding(.horizontal, 44)
                .padding(.vertical, 18)
            
         
        }
    }
}

struct WeatherListItemView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherListItemView(.init(rawTemp: 53,
                                  tempHigh: 12,
                                  tempLow: 94,
                                  location: "McAllen TX",
                                  condition: "Rain",
                                  iconId: "10d"))
    }
}
