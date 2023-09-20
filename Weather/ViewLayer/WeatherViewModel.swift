//
//  WeatherListViewViewModel.swift
//  Weather
//
//  Created by Josh Franco on 9/19/23.
//

import Foundation

protocol WeatherViewModelCoordinatorDelegate: AnyObject {
    func weatherListDidTapInputButton()
}

class WeatherViewModel: ObservableObject {
    @Published var weatherList: [Weather] = []
    @Published var isLoading = false
    
    weak var coordinator: WeatherViewModelCoordinatorDelegate?
    
    // MARK: - Init
    
    init() {
        loadSavedWeatherIfPossible()
    }
    
    func inputViewButtonTap() {
        coordinator?.weatherListDidTapInputButton()
    }
}

// MARK: - Private

private extension WeatherViewModel {
    func loadSavedWeatherIfPossible() {
        if let savedWeather = PersistencyManager.shared.loadWeather() {
            weatherList.append(savedWeather)
        } else {
            isLoading = true
            DataManager.shared.getCurrentLocationWeather { result in
                switch result {
                case .success(let weather):
                    let idSet = Set(self.weatherList.map({ $0.id }))
                    guard !idSet.contains(weather.id) else { break }
                    
                    DispatchQueue.main.async {
                        self.weatherList.append(weather)
                    }
                    
                    PersistencyManager.shared.saveWeather(weather)
                case .failure(let failure):
                    // MARK: TODO - Handle Failures with alerts
                    print("fail - \(failure)")
                }
                
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
    }
}
