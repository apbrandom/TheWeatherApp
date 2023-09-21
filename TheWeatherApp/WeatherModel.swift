//
//  WeatherModel.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 17.09.2023.
//

import Foundation

struct WeatherModel {
    let nowDt: String
    let fact: FactModel
    let forecasts: [ForecastsModel]
}

struct FactModel {
    let temp: Int
    let feelsLike: Int
}

struct ForecastsModel {
    let sunrise: String
}

extension WeatherModel {
    init(from databaseModel: WeatherDatabaseModel) {
        self.nowDt = databaseModel.nowDt
        self.fact = FactModel(temp: Int(databaseModel.fact.temp), feelsLike: Int(databaseModel.fact.feelsLike))
        
        self.forecasts = databaseModel.forecasts.map { ForecastsModel(sunrise: $0.sunrise) }
    }
}



