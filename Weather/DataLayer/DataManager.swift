//
//  DataManager.swift
//  Weather
//
//  Created by Josh Franco on 9/19/23.
//

import Foundation
import Combine
import CoreLocation

class DataManager {
    static var shared = DataManager()
    
    let networkingService = NetworkingService()
    let locationService = LocationService()
    let warehouse: Set<AnyCancellable> = []
    
    func getCurrentLocationWeather() {
        
    }
}

// MARK: - Private

private extension DataManager {
    enum DataError: Error {
        case noCoordinateData
    }
    
    func getCurrentLocation(result: @escaping (Result<CLLocationCoordinate2D?, Error>) -> Void) {
        let resultBlock: ((Result<CLLocationCoordinate2D?, Error>) -> Void) = { locationResult in
            switch locationResult {
            case .success(let coordinate):
                result(.success(coordinate))
            case .failure(let error):
                result(.failure(error))
            }
        }
        
        if locationService.hasPermission {
            locationService.requestPermission {
                self.locationService.requestLocation(result: resultBlock)
            }
        } else {
            locationService.requestLocation(result: resultBlock)
        }
    }
    
    func getWeather(for coordinate: CLLocationCoordinate2D?, result: @escaping (Result<Weather, Error>) -> Void) {
        guard let coordinate = coordinate else { return result(.failure(DataError.noCoordinateData)) }
        
        
        
    }
}
