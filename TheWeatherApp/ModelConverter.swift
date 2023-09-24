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
        
        //nowDt
        realmModel.nowDt = networkModel.nowDt
        
        //Fact
        let realmModelFact = FactRealm()
        realmModelFact.temp = networkModel.fact.temp
        realmModelFact.windSpeed = networkModel.fact.windSpeed
        realmModelFact.humudity = networkModel.fact.humidity
        realmModel.fact = realmModelFact
                
        //Forecasts
        networkModel.forecasts.forEach {
            let forecastRealm = ForecastsRealm()
            forecastRealm.date = $0.date
            forecastRealm.sunrise = $0.sunrise
            forecastRealm.sunset = $0.sunset
            realmModel.forecasts.append(forecastRealm)
        }
        
        return realmModel
    }
    
    func toViewModel(from realmModel: WeatherRealmModel) -> WeatherViewModel {
        //Fact
        let factRealModel = realmModel.fact
        let factViewModel = FactViewModel(temp: factRealModel?.temp ?? 0,
                                          windSpeed: factRealModel?.windSpeed ?? 0.0,
                                          humidity: factRealModel?.humudity ?? 0)
        
        // Forecasts
        let forecastsViewModel = Array(realmModel.forecasts.map {
            ForecastsViewModel(date: $0.date, sunrise: $0.sunrise, sunset: $0.sunset)
        })
        
        return WeatherViewModel(nowDt: realmModel.nowDt, fact: factViewModel, forecasts: forecastsViewModel)
    }
}

