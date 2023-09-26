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

struct FactViewModel: Decodable {
    let temp: Int
    let windSpeed: Double //
    let humidity: Int //
}

struct ForecastsViewModel: Decodable {
    let date: String //
    let sunrise: String
    let sunset: String //
    let parts: PartsViewModel
}

struct PartsViewModel: Decodable {
    let day: PartDetailsViewModel
}

struct PartDetailsViewModel: Decodable {
    let tempMin: Int
    let tempMax: Int
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


