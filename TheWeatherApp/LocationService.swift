//
//  LocationService.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 30.09.2023.
//

import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationService()  // Синглтон для доступа к экземпляру этого сервиса из любой части приложения
    
    private var locationManager: CLLocationManager  // Менеджер геолокации для работы с сервисами геолокации
    var authorizationStatus: ((CLAuthorizationStatus) -> Void)?  // Кложура для получения статуса авторизации
    
    private override init() {
        self.locationManager = CLLocationManager()
        super.init()
        self.locationManager.delegate = self  // Установка делегата
    }
    
    // Запрос разрешения на использование геолокации
    func requestPermission() {
        DispatchQueue.main.async {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    // Проверка статуса авторизации для геолокации
    func checkAuthorizationStatus(
        authorized: @escaping () -> Void,
        unauthorized: @escaping () -> Void
    ) {
        let status = locationManager.authorizationStatus
        
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
    
    // Метод делегата, вызывается при изменении статуса авторизации
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        authorizationStatus?(status)
        
        guard status == .authorizedWhenInUse || status == .authorizedAlways else {
            // TODO: Handle unauthorized status, perhaps inform the user
            return
        }
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.getCurrentLocation()
        }
    }
    
    // Метод делегата, вызывается при обновлении геолокации
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        print("Текущая геолокация: \(location)")
        
        // Останавливаем обновление геолокации, если оно больше не нужно
        locationManager.stopUpdatingLocation()
    }
    
    // Получение текущей геолокации пользователя
    func getCurrentLocation() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard CLLocationManager.locationServicesEnabled() else {
                // TODO: Inform the user that location services are not enabled.
                return
            }
            
            self?.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self?.locationManager.startUpdatingLocation()
        }
    }

    
    
}
