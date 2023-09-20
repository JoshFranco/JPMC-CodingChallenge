//
//  WeatherInputView.swift
//  Weather
//
//  Created by Josh Franco on 9/19/23.
//

import SwiftUI

struct WeatherInputView: View {
    @StateObject var viewModel: InputViewModel
    
    var body: some View {
        ZStack {
            InternalColor.darkBlue.asColor
                .ignoresSafeArea()
            
            VStack {
                ScrollView {
                    Spacer(minLength: 16)
                    
                    HStack {
                        TextField("", text: $viewModel.searchInput)
                            .foregroundColor(.white)
                            .placeholder(when: viewModel.searchInput.isEmpty) {
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
                            // TODO - Use this button to reactivate the users current location
                        } label: {
                            Image(systemName: "location.circle")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 24, height: 24)
                        }
                    }
                    
                    ForEach(viewModel.searchResults) { result in
                        VStack(alignment: .leading) {
                            Button {
                                // Do stuff
                            } label: {
                                Text("\(result.name), \(result.state ?? "n/a"), \(result.countryCode)")
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        }
                    }
                }
                
                Button {
                    viewModel.search()
                } label: {
                    Text("Search")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .background(InternalColor.lightBlue.asColor)
                .clipShape(RoundedRectangle(cornerRadius: 5))

            }
            .padding()
            
            if viewModel.isLoading {
                ActivityIndicator()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.orange)
            }
        }
        .alert(viewModel.alertMessage, isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

// MARK: - Preview

struct WeatherInputView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherInputView(viewModel: .init())
    }
}


