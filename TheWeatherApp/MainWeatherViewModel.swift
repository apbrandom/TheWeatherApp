//
//  MainWeatherViewModel.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 13.09.2023.
//

import Foundation

class MainWeatherViewModel {
    
    private let networkService: NetworkService
    private let realmService: RealmService
    private let modelConverter: ModelConverter
    
    internal var fixedHeightSubviews: CGFloat = 0.0
    internal let numberOfSubviews: CGFloat = 3.0
    internal var hourlyWeatherData: [HourViewModel] = []
    
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
    
    func fetchWeather() async throws -> WeatherViewModel? {
        do {
            let networkModel = try await networkService.fetchNetworkModel()
            let realmModel = modelConverter.toRealmModel(from: networkModel)
            try await realmService.saveOrUpdateWeather(realmModel)
            guard let viewModel = modelConverter.toViewModel(from: realmModel) else { return nil }
            
            if let forecast = viewModel.forecasts.first {
                self.hourlyWeatherData = forecast.hours
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




