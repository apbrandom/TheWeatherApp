//
//  LocationService.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 30.09.2023.
//

import CoreLocation

class LocationService: NSObject {
    
    static let shared = LocationService()
    
    var requestPermission: (() -> Void)?
    
    var locationManager: CLLocationManager?
    var didUpdateLocation: ((CLLocationCoordinate2D) -> Void)?
    
    func checkLocationService() {
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager = CLLocationManager()
            self.locationManager?.delegate = self
            self.locationManager?.desiredAccuracy = kCLLocationAccuracyKilometer
        } else {
            print("Location Service is not enabled")
        }
        
    }
    
    func checkLocationAutorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            
            requestPermission?()

        case .restricted:
            print("Your location is restricted likely due to parental controls.")
        case .denied:
            print("You have denied this app location permission. Go into settings to change it.")
        case .authorizedAlways, .authorizedWhenInUse:
            DispatchQueue.main.async { [weak self] in
                self?.locationManager?.startUpdatingLocation()
            }
        @unknown default:
            break
        }
    }
    
    func requestOnTimeLocation() {
        locationManager?.requestLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAutorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        didUpdateLocation?(location.coordinate)
        
        
        print("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)")
        manager.stopUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager?.stopUpdatingLocation()

            if let clErr = error as? CLError {
                switch clErr.code {
                case .locationUnknown, .denied, .network:
                    print("Location request failed with error: \(clErr.localizedDescription)")
                case .headingFailure:
                    print("Heading request failed with error: \(clErr.localizedDescription)")
                case .rangingUnavailable, .rangingFailure:
                    print("Ranging request failed with error: \(clErr.localizedDescription)")
                case .regionMonitoringDenied, .regionMonitoringFailure, .regionMonitoringSetupDelayed, .regionMonitoringResponseDelayed:
                    print("Region monitoring request failed with error: \(clErr.localizedDescription)")
                default:
                    print("Unknown location manager error: \(clErr.localizedDescription)")
                }
            } else {
                print("Unknown error occurred while handling location manager error: \(error.localizedDescription)")
            }
        }
}

extension LocationService {
    func getCurrentLocation() async -> CLLocationCoordinate2D? {
        return await withCheckedContinuation { continuation in
            self.didUpdateLocation = { location in
                continuation.resume(returning: location)
            }
            
            self.requestPermission = {
                continuation.resume(returning: nil)
            }
            
            self.requestOnTimeLocation()
        }
    }
}
