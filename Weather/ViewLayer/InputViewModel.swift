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
     */
}
