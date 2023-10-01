//
//  LocationService.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 30.09.2023.
//

import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationService()
    
    private var locationManager: CLLocationManager?
    var authorizationStatus: ((CLAuthorizationStatus) -> Void)?
    
    private override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
    }
    
    func requestPermission() {
        DispatchQueue.main.async {
            self.locationManager?.requestWhenInUseAuthorization()
        }
    }
    
    func checkAuthorizationStatus(
        authorized: @escaping () -> Void,
        unauthorized: @escaping () -> Void
    ) {
        let status: CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            status = locationManager?.authorizationStatus ?? .notDetermined
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            authorized()
            
        case .denied, .restricted, .notDetermined:
            unauthorized()
            
        @unknown default:
            unauthorized()
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        authorizationStatus?(status)
        
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            DispatchQueue.global(qos: .background).async { [weak self] in
                self?.getCurrentLocation()
            }
        } else {
            // TODO: Handle unauthorized status, perhaps inform the user
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        print("Текущая геолокация: \(location)")
        
        // Optionally stop updating location if it's no longer needed
        locationManager?.stopUpdatingLocation()
    }
    
    func getCurrentLocation() {
        // Removing DispatchQueue.main.async as it's not required here
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager?.startUpdatingLocation()
        } else {
            // TODO: Inform the user that location services are not enabled.
        }
    }
}
