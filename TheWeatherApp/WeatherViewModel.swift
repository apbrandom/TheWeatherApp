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
}

struct ForecastsViewModel {
    let sunrise: String
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


