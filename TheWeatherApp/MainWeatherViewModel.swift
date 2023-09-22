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
    
    internal var fixedHeightSubviews: CGFloat = 0.0
    private let numberOfSubviews: CGFloat = 3.0
    
    init(networkService: NetworkService, realmService: RealmService) {
        self.networkService = networkService
        self.realmService = realmService
    }
    
    func fetchWeather() async throws -> WeatherViewModel {
            do {
                let networkModel = try await networkService.fetchNetworkModel()
                let realmModel = convertToRealmModel(networkModel: networkModel)
                try await realmService.saveOrUpdateWeather(realmModel)
                return convertToViewModel(from: realmModel)
            } catch {
                print("Error fetching weather from network: \(error)")
                do {
                    if let cachedModel = try await realmService.fetchCachedWeather() {
                        return convertToViewModel(from: cachedModel)
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
    
    private func convertToRealmModel(networkModel: WeatherNetworkModel) -> WeatherRealmModel {
        let factRealmModel = FactRealmModel(temp: networkModel.fact.temp)
        let realmModel = WeatherRealmModel(nowDt: networkModel.nowDt)
        realmModel.fact = factRealmModel
        return realmModel
    }
    
    private func convertToViewModel(from realmModel: WeatherRealmModel) -> WeatherViewModel {
        let factVM = FactViewModel(temp: realmModel.fact?.temp ?? 0)
        return WeatherViewModel(nowDt: realmModel.nowDt, fact: factVM)
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




