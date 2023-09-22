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
    private let numberOfSubviews: CGFloat = 3.0
    
    init(networkService: NetworkService, realmService: RealmService, modelConverter: ModelConverter) {
        self.networkService = networkService
        self.realmService = realmService
        self.modelConverter = modelConverter
    }
    
    func fetchWeather() async throws -> WeatherViewModel {
        do {
            let networkModel = try await networkService.fetchNetworkModel()
            let realmModel = modelConverter.toRealmModel(networkModel: networkModel)
            try await realmService.saveOrUpdateWeather(realmModel)
            return modelConverter.toViewModel(from: realmModel)
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
    
    func getFixedHeightSubviews() -> CGFloat {
        return fixedHeightSubviews
    }
    
    func getNumberOfSubviews() -> CGFloat {
        return numberOfSubviews
    }
    
    enum WeatherError: Error {
        case noCachedData
        case failedToFetchData
    }
}




