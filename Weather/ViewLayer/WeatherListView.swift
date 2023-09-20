//
//  WeatherListView.swift
//  Weather
//
//  Created by Josh Franco on 9/19/23.
//

import SwiftUI

struct WeatherListView: View {
    @StateObject var viewModel = WeatherListViewViewModel()
    
    var body: some View {
        ZStack {
            InternalColor.darkBlue.asColor
                .ignoresSafeArea()
            
            ScrollView {
                Button {
                    // DO stuff
                } label: {
                    HStack {
                        Text("Search for new location")
                            .foregroundColor(.white)
                            .font(.caption)
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                    }
                    .padding(8)
                    .background(InternalColor.lightBlue.asColor)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    
                    
                }

                
                WeatherListItemView(.init(rawTemp: 53,
                                          tempHigh: 12,
                                          tempLow: 94,
                                          location: "McAllen TX",
                                          condition: "Rain",
                                          iconId: "10d"))
                
                WeatherListItemView(.init(rawTemp: 53,
                                          tempHigh: 12,
                                          tempLow: 94,
                                          location: "McAllen TX",
                                          condition: "Rain",
                                          iconId: "10d"))
                
            }
            
        }
    }
}

struct WeatherListView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherListView()
    }
}
