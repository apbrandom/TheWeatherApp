//
//  WeatherModel.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 17.09.2023.
//

import Foundation

struct WeatherViewModel {
    let nowDt: String
    let fact: FactViewModel
    let forecasts: [ForecastsViewModel]
}

struct FactViewModel {
    let temp: Int
    let windSpeed: Double //
    let humidity: Int //
}

struct ForecastsViewModel {
    let date: String //
    let sunrise: String
    let sunset: String //
    let parts: PartsViewModel
    let hours: [HourViewModel]
}

struct PartsViewModel {
    let day: PartDetailsViewModel
}

struct PartDetailsViewModel {
    let tempMin: Int
    let tempMax: Int
    let precProb: Int
}
    
    
struct HourViewModel {
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


