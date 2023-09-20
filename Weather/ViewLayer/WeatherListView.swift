//
//  WeatherListView.swift
//  Weather
//
//  Created by Josh Franco on 9/19/23.
//

import SwiftUI

struct WeatherListView: View {
    @StateObject var viewModel: WeatherViewModel
    
    var body: some View {
        ZStack {
            InternalColor.darkBlue.asColor
                .ignoresSafeArea()
            
            ScrollView {
                Button {
                    viewModel.inputViewButtonTap()
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

                ForEach(viewModel.weatherList) { weather in
                    WeatherListItemView(weather)
                }                
            }
            
            if viewModel.isLoading {
                ActivityIndicator()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.orange)
            }
        }
    }
}

struct WeatherListView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherListView(viewModel: .init())
    }
}
