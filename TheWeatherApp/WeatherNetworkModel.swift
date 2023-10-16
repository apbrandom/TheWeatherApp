//
//  Weather.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 13.09.2023.
//

import Foundation

struct WeatherNetworkModel: Decodable {
    let nowDt: String
    let fact: Fact
    let forecasts: [Forecasts]
}

struct Fact: Decodable {
    let temp: Int
    let windSpeed: Double 
    let humidity: Int
}

struct Forecasts: Decodable {
    let date: String
    let sunrise: String
    let sunset: String
    let parts: Parts
    let hours: [Hour]
}

struct Parts: Decodable {
    let day: PartDetails
}

struct PartDetails: Decodable {
    let tempMin: Int
    let tempMax: Int
    let precProb: Int
}

struct Hour: Decodable {
    let hour: String
    let temp: Int
    let condition: String
    let humidity: Int
}
