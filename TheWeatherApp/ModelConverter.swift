//
//  ModelConverterService.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 22.09.2023.
//

import Foundation

class ModelConverter {
    
    func toRealmModel(networkModel: WeatherNetworkModel) -> WeatherRealmModel {
        let factRealmModel = FactRealmModel(temp: networkModel.fact.temp)
        let realmModel = WeatherRealmModel(nowDt: networkModel.nowDt)
        realmModel.fact = factRealmModel
        return realmModel
    }
    
    func toViewModel(from realmModel: WeatherRealmModel) -> WeatherViewModel {
        let factVM = FactViewModel(temp: realmModel.fact?.temp ?? 0)
        return WeatherViewModel(nowDt: realmModel.nowDt, fact: factVM)
    }
}
