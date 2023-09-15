//
//  Weather.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 13.09.2023.
//

import Foundation

struct WeatherModel: Decodable {
    let now: Int
    let nowDt: String
    let info: Info
    let fact: Fact
    let forecasts: [Forecast]
}

struct Info: Decodable {
    let lat: Double
    let lon: Double
    let tzinfo: Tzinfo
    let defPressureMm: Int
    let defPressurePa: Int
    let url: String
}

struct Tzinfo: Decodable {
    let offset: Int
    let name: String
    let abbr: String
    let dst: Bool
}

struct Fact: Decodable {
    let temp: Int
    let feelsLike: Int
    let icon: String
    let condition: String
    let windSpeed: Double
    let windGust: Double
    let windDir: String
    let pressureMm: Int
    let pressurePa: Int
    let humidity: Int
    let daytime: String
    let polar: Bool
    let season: String
    let precType: Int
    let precStrength: Double
    let isThunder: Bool
    let cloudness: Double
    let obsTime: Int
    let phenomIcon: String?
    let phenomCondition: String?
}

struct Forecast: Decodable {
    let date: String
    let dateTs: Int
    let week: Int
    let sunrise: String
    let sunset: String
    let moonCode: Int
    let moonText: String
    let parts: Parts
    let hours: [Hour]
}

struct Parts: Decodable {
    let night: PartDetails
}

struct PartDetails: Decodable {
    let tempMin: Int
    let tempMax: Int
    let tempAvg: Int?
    let feelsLike: Int
    let icon: String
    let condition: String
    let daytime: String
    let polar: Bool
    let windSpeed: Double
    let windGust: Double
    let windDir: String
    let pressureMm: Int
    let pressurePa: Int
    let humidity: Int
    let precMm: Double?
    let precPeriod: Int?
    let precType: Int
    let precStrength: Double
    let cloudness: Double
}

struct Hour: Decodable {
    let hour: String
    let hourTs: Int
    let temp: Int
    let feelsLike: Int
    let icon: String
    let condition: String
    let windSpeed: Double
    let windGust: Double
    let windDir: String
    let pressureMm: Int
    let pressurePa: Int
    let humidity: Int
    let precMm: Double?
    let precPeriod: Int?
    let precType: Int
    let precStrength: Double
    let isThunder: Bool
    let cloudness: Double
}
