//
//  MainWeatherViewModel.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 13.09.2023.
//

import Foundation

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
    
    func fetchWeather() async throws -> WeatherViewModel? {
        do {
            let networkModel = try await networkService.fetchNetworkModel()
            let realmModel = modelConverter.toRealmModel(from: networkModel)
            try await realmService.saveOrUpdateWeather(realmModel)
            guard let viewModel = modelConverter.toViewModel(from: realmModel) else { return nil }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
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
    
    enum WeatherError: Error {
        case noCachedData
        case failedToFetchData
    }
}




