//
//  WeatherDatabaseModel.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 17.09.2023.
//

import Foundation

//struct WeatherDatabaseModel {
//    let nowDt: String
//    let fact: FactDatabaseModel
//    let forecasts: [ForecastsDatabaseModel]
//}
//
//struct FactDatabaseModel {
//    let temp: Int64
//    let feelsLike: Int64
//}
//
//struct ForecastsDatabaseModel {
//    let sunrise: String
//}
//
//extension WeatherDatabaseModel {
//    init(from networkModel: WeatherNetworkModel) {
//        self.nowDt = networkModel.nowDt
//        self.fact = FactDatabaseModel(temp: Int64(networkModel.fact.temp), feelsLike: Int64(networkModel.fact.feelsLike))
//        
//        // Проверка, что массив прогнозов не пуст
//        if networkModel.forecasts.isEmpty {
//            self.forecasts = []
//        } else {
//            self.forecasts = networkModel.forecasts.map { ForecastsDatabaseModel(sunrise: $0.sunrise) }
//        }
//    }
//}


