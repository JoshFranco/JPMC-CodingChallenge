//
//  DataManager.swift
//  Weather
//
//  Created by Josh Franco on 9/19/23.
//

import Combine
import CoreLocation

class DataManager {
    static var shared = DataManager()
    
    private let networkingService = NetworkingService()
    private let locationService = LocationService()
     
    private var warehouse: Set<AnyCancellable> = []
    
    // MARK: - Init
    
    private init() {}
    
    // MARK: - API's
    
    func getCurrentLocationWeather(result: @escaping (Result<Weather, Error>) -> Void) {
        getCurrentLocation { locationResult in
            switch locationResult {
            case .success(let coord):
                self.getWeather(for: coord,
                                result: result)
            case .failure(let error):
                print("Fatal Error: \(error)")
            }
        }
    }
    
    func getWeather(for coordinate: CLLocationCoordinate2D?, result: @escaping (Result<Weather, Error>) -> Void) {
        let group = DispatchGroup()
        var weatherData: OpenWeatherDTO?
        var geocoding: [GeocodingDTO]?
        var error: [Error] = []
        
        group.enter()
        self.getWeatherData(for: coordinate) { weatherResult in
            switch weatherResult {
            case .success(let weather):
                weatherData = weather
            case .failure(let failure):
                error.append(failure)
            }
            
            group.leave()
        }
        
        group.enter()
        self.getLocationDetails(for: coordinate) { locationResult in
            switch locationResult {
            case .success(let success):
                geocoding = success
            case .failure(let failure):
                error.append(failure)
            }
            
            group.leave()
        }
        
        group.notify(queue: .global(qos: .userInteractive)) {
            guard
                let weather = weatherData,
                let location = geocoding?.first
            else {
                result(.failure(error.first ?? DataError.unknown))
                return
            }
            
            result(.success(.init(weatherDTO: weather, location: location)))
        }
    }
    
    func getLocations(cityName: String, result: @escaping (Result<[SearchObj], Error>) -> Void) {
        getLocationDetails(for: cityName) { locationResult in
            switch locationResult {
            case .success(let success):
                let resultObj = success.map({ SearchObj(geocoding: $0) })
                result(.success(resultObj))
            case .failure(let failure):
                result(.failure(failure))
            }
        }
    }
}

// MARK: - Private

private extension DataManager {
    enum DataError: Error {
        case noCoordinateData
        case unknown
    }
    
    func getCurrentLocation(result: @escaping (Result<CLLocationCoordinate2D?, Error>) -> Void) {
        var hasPermissionBlockTriggered = false
        let resultBlock: ((Result<CLLocationCoordinate2D?, Error>) -> Void) = { locationResult in
            switch locationResult {
            case .success(let coordinate):
                result(.success(coordinate))
            case .failure(let error):
                result(.failure(error))
            }
        }
        
        if !locationService.hasPermission {
            locationService.requestPermission { authStatus in
                switch authStatus {
                case .notDetermined:
                    break   // Wait
                case .denied, .restricted:
                    // TODO - have the data manager fail gracefully
                    break
                default:
                    /// This is needed due to the location service sending multiple signals that the auth status has been updated
                    if !hasPermissionBlockTriggered {
                        hasPermissionBlockTriggered = true
                        self.locationService.requestLocation(result: resultBlock)
                    }
                }
            }
        } else {
            locationService.requestLocation(result: resultBlock)
        }
    }
    
    func getWeatherData(for coordinate: CLLocationCoordinate2D?, result: @escaping (Result<OpenWeatherDTO, Error>) -> Void) {
        guard let coordinate = coordinate else { return result(.failure(DataError.noCoordinateData)) }
        
        let request: AnyPublisher<OpenWeatherDTO, APIError> = networkingService.request(.openWeather,
                                                                                        headers: nil,
                                                                                        queryParameters: ["lat": "\(coordinate.latitude)",
                                                                                                          "lon": "\(coordinate.longitude)",
                                                                                                          "appid": Constants.openWeatherAPIKey,
                                                                                                          "units": "imperial"],
                                                                                        body: nil)
        request
            .sink(receiveCompletion: { receive in
                switch receive {
                case .failure(let error):
                    result(.failure(error))
                default: break
                }
            }, receiveValue: { weather in
                result(.success(weather))
            })
            .store(in: &warehouse)
    }
    
    func getLocationDetails(for coordinate: CLLocationCoordinate2D?, result: @escaping (Result<[GeocodingDTO], Error>) -> Void) {
        guard let coordinate = coordinate else { return result(.failure(DataError.noCoordinateData)) }
        
        let request: AnyPublisher<[GeocodingDTO], APIError> = networkingService.request(.reverseGeocoding,
                                                                                      headers: nil,
                                                                                      queryParameters: ["lat": "\(coordinate.latitude)",
                                                                                                        "lon": "\(coordinate.longitude)",
                                                                                                        "limit": "5",
                                                                                                        "appid": Constants.openWeatherAPIKey],
                                                                                      body: nil)
        request
            .sink { receive in
                switch receive {
                case .failure(let error):
                    result(.failure(error))
                default: break
                }
            } receiveValue: { geocoding in
                result(.success(geocoding))
            }
            .store(in: &warehouse)
    }
    
    func getLocationDetails(for city: String, result: @escaping (Result<[GeocodingDTO], Error>) -> Void) {
        let request: AnyPublisher<[GeocodingDTO], APIError> = networkingService.request(.geocoding,
                                                                                        headers: nil,
                                                                                        queryParameters: ["q": "\(city)",
                                                                                                          "limit": "5",
                                                                                                          "appid": Constants.openWeatherAPIKey],
                                                                                        body: nil)
        request
            .sink { receive in
                switch receive {
                case .failure(let error):
                    result(.failure(error))
                default: break
                }
            } receiveValue: { geocoding in
                result(.success(geocoding))
            }
            .store(in: &warehouse)
    }
}
