//
//  InputViewModel.swift
//  Weather
//
//  Created by Josh Franco on 9/20/23.
//

import Foundation

protocol InputViewModelCoordinatorDelegate: AnyObject {
    func updateWithWeather(_ weather: Weather)
}

class InputViewModel: ObservableObject {
    @Published var searchInput: String = ""
    @Published var searchResults: [SearchObj] = []
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var isLoading = false
    
    init() {
    }
    
    func search() {
        isLoading = true
        DataManager.shared.getLocations(cityName: searchInput) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.searchResults = success
                }
            case .failure:
                DispatchQueue.main.async {
                    self.searchResults.removeAll()
                    self.alertMessage = "Incorrect formate, use following formate: \n(City Name, State Code, Country Code)"
                    self.showAlert = true
                }
            }
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }

    /*
     NEXT STEPS:
        - If the user selects a search cell then pass that weather object back to the coordinator and through to the list view
        - The view model for the list view will be responsible for updating with the new weather object
        - The weather object can be constructed by using the lat and lon from the geocoding API call that was done by the "getLocations" func
        - Make better search cells with more info
        - Use more of the data provided by the API such as humidity and real feel
        - Work on edge error cases
     
     Big thank you to whomever has taken the time to look through my code, I got as much done as I could with the allotted time and home we can have a nice discussion about my chosen architecture/coding patterns
     
     QUICK NOTE ON ARCH PATTERN:
        - I was trying to use CLEAN arch for this project and separate the code out via layers, currently for my managers I am just using singletons but I would like to use dependency injection via property wrappers. I good SDK to make this simple is "Factory"
        - Using a coordinator pattern for the navigation due to it using the best parts of UIKit and the speed of SwiftUI views
     */
}
