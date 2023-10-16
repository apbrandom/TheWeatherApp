//
//  MainWeatherViewModel.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 13.09.2023.
//

import Foundation
import UIKit
import CoreLocation

protocol WeatherObserver {
    func didUpdateWeather(_ weather: WeatherModel)
    func updateUI(with weather: WeatherModel)
}

protocol TitleObservable {
    func didUpdateLocationName(_ locationName: String)
}

class WeatherViewModel {
    
    private let networkService: NetworkService
    private let realmService: RealmService
    private let modelConverter: ModelConverter
    
    private var weatherObservers: [WeatherObserver] = []
    private var titleObservers: [TitleObservable] = []
    var weatherCondition: WeatherCondition?
    var weatherForecasts: [ForecastsModel?] = []
    var conditionImages: [UIImage] = []
    
    var latitude: CLLocationDegrees = 55.7558
    var longitude: CLLocationDegrees = 37.6173
    internal var fixedHeightSubviews: CGFloat = 0.0
    internal let numberOfSubviews: CGFloat = 3.0
    
    init(networkService: NetworkService, realmService: RealmService, modelConverter: ModelConverter) {
        self.networkService = networkService
        self.realmService = realmService
        self.modelConverter = modelConverter
    }
    
    func fetchLocationName() async -> String? {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        var locationName: String?
        
        let _ = await withCheckedContinuation { (continuation: CheckedContinuation<String?, Never>) in
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let error = error {
                    print("Geocoding error: \(error)")
                    continuation.resume(returning: nil)
                    return
                }
                
                if let placemark = placemarks?.first,
                   let city = placemark.locality,
                   let country = placemark.country {
                    locationName = "\(country), \(city)"
                    continuation.resume(returning: locationName)
                } else {
                    continuation.resume(returning: nil)
                }
            }
        }
        return locationName
    }
    
    
    func fetchWeather() async throws -> WeatherModel? {
        
        let lat = String(latitude)
        let lon = String(longitude)
        do {
            let networkModel = try await networkService.fetchNetworkModel(lat: lat , lon: lon)
            let realmModel = modelConverter.toRealmModel(from: networkModel)
            try await realmService.saveOrUpdateWeather(realmModel)
            guard let viewModel = modelConverter.toViewModel(from: realmModel) else { return nil }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.weatherForecasts = viewModel.forecasts
                
                self.conditionImages.removeAll()
                
                guard let hours = self.weatherForecasts.first??.hours else { return }
                for hour in hours {
                    let condition = hour.condition
                    self.setWeatherCondition(from: condition)
                    if let image = self.getWeatherImage() {
                        self.conditionImages.append(image)
                    }
                }
                
                self.notifyWeatherObservers(viewModel)
            }
            
            return viewModel
        } catch {
            print("Error fetching weather from network: \(error)")
            do {
                if let cachedModel = try await realmService.fetchCachedWeather() {
                    return modelConverter.toViewModel(from: cachedModel)
                } else {
                    print("No cached data available")
                    throw WeatherError.noCachedData
                }
            } catch {
                print("Error fetching cached data: \(error)")
                throw WeatherError.failedToFetchData
            }
        }
    }
    
    func fetchDataAndUpdateUI() async {
        // Получение координат
        if let coordinate = await LocationService.shared.getCurrentLocation() {
            self.latitude = coordinate.latitude
            self.longitude = coordinate.longitude
        }
        
        // Получение данных о погоде
        do {
            if let weatherViewModel = try await fetchWeather() {
                // Обновление UI
                DispatchQueue.main.async { [weak self] in
                    self?.notifyWeatherObservers(weatherViewModel)
                }
            }
        } catch {
            print("Ошибка при получении данных о погоде: \(error)")
        }
        
        if let locationName = await fetchLocationName() {
            DispatchQueue.main.async { [weak self] in
                self?.notifyTitleObservers(locationName)
            }
        }
    }
    
    func getFixedHeightSubviews() -> CGFloat {
        return fixedHeightSubviews
    }
    
    func getNumberOfSubviews() -> CGFloat {
        return numberOfSubviews
    }
    
    func setWeatherCondition(from string: String) {
        weatherCondition = WeatherCondition(rawValue: string)
    }
    
    func getWeatherImage() -> UIImage? {
        guard let condition = weatherCondition else { return nil }
        
        switch condition {
        case .clear:
            return UIImage(resource: .sun)
        case .partlyCloudy:
            return UIImage(resource: .sunIndex)
        case .cloudy:
            return UIImage(resource: .cloudy)
        case .overcast:
            return UIImage(resource: .overcast)
        case .rain:
            return UIImage(resource: .humidity)
        case .heavyRain:
            return UIImage(resource: .humidity)
        case .lightRain:
            return UIImage(resource: .humidity)
        default:
            return UIImage(systemName: "cloud.sun")
        }
    }
    
    func getWeatherCondition() -> String {
        let condition = weatherCondition
        
        switch condition {
        case .clear:
            return "Ясно"
        case .partlyCloudy:
            return "Малооблачно"
        case .cloudy:
            return "Облачно с прояснениям"
        case .overcast:
            return "Пасмурно"
        case .rain:
            return "Дождь"
        case .heavyRain:
            return "Cильный дождь"
        case .lightRain:
            return "небольшой дождь"
        case .snow:
            return "Снег"
        case .hail:
            return "Град"
        case .thunderstormWithRain:
            return "Дождь с грозой"
        case .thunderstormWithHail:
            return "гроза с градом"
        default:
            return "Обычная погода, ничего особенного"
        }
    }
    
    enum WeatherError: Error {
        case noCachedData
        case failedToFetchData
    }
}

enum WeatherCondition: String {
    case clear
    case partlyCloudy = "partly-cloudy"
    case cloudy
    case overcast
    case rain
    case lightRain =  "light-rain"
    case heavyRain = "heavy-rain"
    case showers
    case wetSnow = "wet-snow"
    case lightSnow = "light-snow"
    case snow
    case snowShowers = "snow-showers"
    case hail
    case thunderstorm
    case thunderstormWithRain = "thunderstorm-with-rain"
    case thunderstormWithHail = "thunderstorm-with-hail"
}


extension WeatherViewModel {
    //MARK: - Observer Methods
    
    func addWeatherObserver(_ observer: WeatherObserver) {
        weatherObservers.append(observer)
    }
    
    func addTitleObserver(_ observer: TitleObservable) {
        titleObservers.append(observer)
    }
    
    private func notifyTitleObservers(_ locationName: String) {
        for observer in titleObservers {
            observer.didUpdateLocationName(locationName)
        }
    }
    
    private func notifyWeatherObservers(_ weather: WeatherModel) {
        for observer in weatherObservers {
            observer.didUpdateWeather(weather)
        }
    }
}
