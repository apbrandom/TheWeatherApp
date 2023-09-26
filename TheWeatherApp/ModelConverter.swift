//
//  ModelConverterService.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 22.09.2023.
//


import Foundation
import RealmSwift

class ModelConverter {
    
    //MARK: - To Realm Model
    
    func toRealmModel(from networkModel: WeatherNetworkModel) -> WeatherRealmModel {
        let realmModel = WeatherRealmModel()
        
        realmModel.nowDt = networkModel.nowDt
        realmModel.fact = convertToFactRealm(from: networkModel.fact)
        
        let realmForecasts = networkModel.forecasts.map { convertToRealmForecast(from: $0) }
        realmModel.forecasts.append(objectsIn: realmForecasts)
        
        return realmModel
    }
    
    private func convertToFactRealm(from fact: Fact) -> FactRealm {
        let realmFact = FactRealm()
        realmFact.temp = fact.temp
        realmFact.windSpeed = fact.windSpeed
        realmFact.humidity = fact.humidity
        return realmFact
    }
    
    private func convertToRealmForecast(from forecast: Forecasts) -> ForecastsRealm {
        let realmForecast = ForecastsRealm()
        realmForecast.date = forecast.date
        realmForecast.sunrise = forecast.sunrise
        realmForecast.sunset = forecast.sunset
        realmForecast.parts = convertToPartsRealm(from: forecast.parts)
        return realmForecast
    }
    
    private func convertToPartsRealm(from parts: Parts) -> PartsRealm {
        let realmParts = PartsRealm()
        realmParts.day = convertToPartDetailsRealm(from: parts.day)
        return realmParts
    }
    
    private func convertToPartDetailsRealm(from details: PartDetails) -> PartDeteilsRealm {
        let realmDetails = PartDeteilsRealm()
        realmDetails.tempMin = details.tempMin
        realmDetails.tempMax = details.tempMax
        return realmDetails
    }
    
    //MARK: - To ViewModel
    
    func toViewModel(from realmModel: WeatherRealmModel) -> WeatherViewModel? {
        guard let factViewModel = convertToFactViewModel(from: realmModel.fact),
              let forecastsViewModel = convertToForecastsViewModels(from: realmModel.forecasts) else {
            return nil
        }
        
        return WeatherViewModel(nowDt: realmModel.nowDt, fact: factViewModel, forecasts: forecastsViewModel)
    }
    
    private func convertToFactViewModel(from fact: FactRealm?) -> FactViewModel? {
        guard let fact = fact else { return nil }
        return FactViewModel(temp: fact.temp,
                             windSpeed: fact.windSpeed,
                             humidity: fact.humidity)
    }
    
    private func convertToForecastsViewModels(from forecasts: List<ForecastsRealm>) -> [ForecastsViewModel]? {
        let viewModels = Array(forecasts.compactMap { self.convertToForecastsViewModel(from: $0) })
        guard viewModels.count == forecasts.count else { return nil }
        return viewModels
    }
    
    private func convertToForecastsViewModel(from forecast: ForecastsRealm) -> ForecastsViewModel? {
        guard let parts = convertToPartsViewModel(from: forecast.parts) else { return nil }
        return ForecastsViewModel(date: forecast.date,
                                  sunrise: forecast.sunrise,
                                  sunset: forecast.sunset,
                                  parts: parts)
    }
    
    private func convertToPartsViewModel(from parts: PartsRealm?) -> PartsViewModel? {
        guard let parts = parts,
              let day = convertToPartDetailsViewModel(from: parts.day) else {
            return nil
        }
        return PartsViewModel(day: day)
    }
    
    private func convertToPartDetailsViewModel(from details: PartDeteilsRealm?) -> PartDetailsViewModel? {
        guard let details = details else { return nil }
        return PartDetailsViewModel(tempMin: details.tempMin,
                                    tempMax: details.tempMax)
    }
}

