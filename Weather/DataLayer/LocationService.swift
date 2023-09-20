//
//  LocationService.swift
//  Weather
//
//  Created by Josh Franco on 9/19/23.
//

import CoreLocation

class LocationService: NSObject {
    private let manager = CLLocationManager()
    private var locationResult: (Result<CLLocationCoordinate2D?, Error>) -> Void = { _ in }
    private var permCompletion: (CLAuthorizationStatus) -> Void = { _ in }
    
    var hasPermission: Bool {
        switch manager.authorizationStatus {
        case .notDetermined, .restricted, .denied:
            return false
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        @unknown default:
            return false
        }
    }

    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestPermission(completion: @escaping (CLAuthorizationStatus) -> Void) {
        self.permCompletion = completion
        manager.requestWhenInUseAuthorization()
    }
    
    func requestLocation(result: @escaping (Result<CLLocationCoordinate2D?, Error>) -> Void) {
        self.locationResult = result
        manager.requestLocation()
        
    }
}

// MARK: - CLLocationManagerDelegate

extension LocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        permCompletion(manager.authorizationStatus)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationResult(.success(locations.first?.coordinate))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.locationResult(.failure(error))
    }
}
