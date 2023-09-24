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
//    let parts: Parts
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


