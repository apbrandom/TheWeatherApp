//
//  WeatherModel.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 17.09.2023.
//

import Foundation

struct WeatherModel {
    let now: Int
    let nowDt: String
    let temp: Int
    let feelsLike: Int
    
    init(from databaseModel: WeatherDatabaseModel) {
            self.now = Int(databaseModel.now)
            self.nowDt = databaseModel.nowDt
            self.temp = Int(databaseModel.fact.temp)
            self.feelsLike = Int(databaseModel.fact.feelsLike)
        }
}

