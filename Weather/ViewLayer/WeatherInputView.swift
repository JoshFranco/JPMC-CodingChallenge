//
//  WeatherInputView.swift
//  Weather
//
//  Created by Josh Franco on 9/19/23.
//

import SwiftUI

struct WeatherInputView: View {
    @State private var searchInput: String = ""
    
    var body: some View {
        ZStack {
            InternalColor.darkBlue.asColor
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    TextField("", text: $searchInput)
                        .foregroundColor(.white)
                        .placeholder(when: searchInput.isEmpty) {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                
                                Text("Search by City Name, State Code, Conutry Code")
                                    .foregroundColor(.gray)
                                    .font(.caption)
                                
                            }
                            
                        }
                        .padding(4)
                        .overlay( /// apply a rounded border
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.white, lineWidth: 1)
                                
                        )
                    
                    Button {
                        // DO stuff
                    } label: {
                        Image(systemName: "location.circle")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 24, height: 24)
                    }
                }
                
                // create list of search results
                // when the user taps on a search result need to do a api call to get the entire weather object
                
                
                
                Spacer()
            }
            .padding()
        }
    }
}

struct WeatherInputView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherInputView()
    }
}


