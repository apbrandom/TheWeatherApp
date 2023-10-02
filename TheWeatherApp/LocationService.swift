//
//  LocationService.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 30.09.2023.
//

import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationService()  // Синглтон для доступа к экземпляру этого сервиса из любой части приложения
    
    private var locationManager: CLLocationManager?
    
    func checkIfLocationServiceIsEnabled() async -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager = CLLocationManager()
            self.locationManager?.delegate = self
            return true
        } else {
            print("Location Manager is not enabled")
            return false
        }
    }
    
    func checkLocationAutorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted likely due to parental controls.")
        case .denied:
            print("You have denied this app location permission. Go into settings to change it.")
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAutorization()
    }
    
}
