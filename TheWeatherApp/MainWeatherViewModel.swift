//
//  MainWeatherViewModel.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 13.09.2023.
//

import Foundation
import UIKit

protocol WeatherObserver {
    func didUpdateWeather(_ weather: WeatherViewModel)
}

class MainWeatherViewModel {
    
    private let networkService: NetworkService
    private let realmService: RealmService
    private let modelConverter: ModelConverter
    
    internal var fixedHeightSubviews: CGFloat = 0.0
    internal let numberOfSubviews: CGFloat = 3.0
    private var observers: [WeatherObserver] = []
    var weatherCondition: WeatherCondition?
    var weatherForecasts: [ForecastsViewModel?] = []
    
    init(networkService: NetworkService, realmService: RealmService, modelConverter: ModelConverter) {
        self.networkService = networkService
        self.realmService = realmService
        self.modelConverter = modelConverter
    }
    
    func getFixedHeightSubviews() -> CGFloat {
        return fixedHeightSubviews
    }
    
    func getNumberOfSubviews() -> CGFloat {
        return numberOfSubviews
    }
    
    func addObserver(_ observer: WeatherObserver) {
        observers.append(observer)
    }
    
    private func notifyObservers(_ weather: WeatherViewModel) {
        for observer in observers {
            observer.didUpdateWeather(weather)
        }
    }
    
    func fetchWeather(lat: String, lon: String) async throws -> WeatherViewModel? {
        do {
            let networkModel = try await networkService.fetchNetworkModel(lat: lat, lon: lon)
            let realmModel = modelConverter.toRealmModel(from: networkModel)
            try await realmService.saveOrUpdateWeather(realmModel)
            guard let viewModel = modelConverter.toViewModel(from: realmModel) else { return nil }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                weatherForecasts = viewModel.forecasts
                self.notifyObservers(viewModel)
                
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
    
    func convertDate(from isoDate: String) -> String? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = isoFormatter.date(from: isoDate) else {
            print("Bad iso date format")
            return nil
        }
        
        let formartter = DateFormatter()
        formartter.locale = Locale(identifier: "ru_RU")
        formartter.dateFormat = "HH:mm, EEE d MMM"
        
        let resultDate = formartter.string(from: date)
        return resultDate
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


