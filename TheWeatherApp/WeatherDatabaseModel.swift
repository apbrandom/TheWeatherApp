//
//  WeatherDatabaseModel.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 17.09.2023.
//

import Foundation

struct WeatherDatabaseModel {
    let now: Int64
    let nowDt: String
    let fact: FactDatabaseModel
}

struct FactDatabaseModel {
    let temp: Int64
    let feelsLike: Int64
}

extension WeatherDatabaseModel {
    init(from networkModel: WeatherNetworkModel) {
        self.now = Int64(networkModel.now)
        self.nowDt = networkModel.nowDt
        self.fact = FactDatabaseModel(temp: Int64(networkModel.fact.temp), feelsLike: Int64(networkModel.fact.feelsLike))
    }
}
