//
//  ModelConverterService.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 22.09.2023.
//

import Foundation
import RealmSwift

class ModelConverter {
    
    func toRealmModel(from networkModel: WeatherNetworkModel) -> WeatherRealmModel {
        let realmModel = WeatherRealmModel()
        realmModel.nowDt = networkModel.nowDt
        
        // Преобразование Fact
        realmModel.fact = FactRealm(temp: networkModel.fact.temp)
        
        // Преобразование Forecasts
        networkModel.forecasts.forEach {
            let forecastRealm = ForecastsRealm(sunrise: $0.sunrise)
            realmModel.forecasts.append(forecastRealm)
        }
        
        return realmModel
    }
    
    func toViewModel(from realmModel: WeatherRealmModel) -> WeatherViewModel {
        let factViewModel = FactViewModel(temp: realmModel.fact?.temp ?? 0)
        
        // Преобразование Forecasts
        let forecastsViewModel = Array(realmModel.forecasts.map {
            ForecastsViewModel(sunrise: $0.sunrise)
        })
        
        return WeatherViewModel(nowDt: realmModel.nowDt, fact: factViewModel, forecasts: forecastsViewModel)
    }
}

