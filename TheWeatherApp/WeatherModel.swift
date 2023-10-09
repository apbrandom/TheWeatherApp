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
    let windSpeed: Double //
    let humidity: Int //
}

struct ForecastsModel {
    let date: String //
    let sunrise: String
    let sunset: String //
    let parts: PartsModel
    let hours: [HourModel]
}

struct PartsModel {
    let day: PartDetailsModel
}

struct PartDetailsModel {
    let tempMin: Int
    let tempMax: Int
    let precProb: Int
}
    
    
struct HourModel {
    let hour: String
    let temp: Int
    let condition: String
}

    
    
    
//
//    let fact: FactModel
//    let forecasts: [ForecastsModel]
//}
//
//struct FactModel {
//    let temp: Int
//    let feelsLike: Int
//}
//
//struct ForecastsModel {
//    let sunrise: String
//}
//
//


