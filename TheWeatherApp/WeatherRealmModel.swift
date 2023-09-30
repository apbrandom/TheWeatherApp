//
//  WeatherRealmModel.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 21.09.2023.
//

import RealmSwift

class WeatherRealmModel: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var nowDt: String
    @Persisted var fact: FactRealm?
    @Persisted var forecasts = List<ForecastsRealm>()
}
class FactRealm: Object {
    @Persisted var temp: Int
    @Persisted var windSpeed: Double
    @Persisted var humidity: Int
}

class ForecastsRealm: Object {
    @Persisted var date: String
    @Persisted var sunrise: String
    @Persisted var sunset: String
    @Persisted var parts: PartsRealm?
    @Persisted var hours = List<HoursRealm>()
}

class PartsRealm: Object {
    @Persisted var day: PartDeteilsRealm?
}

class PartDeteilsRealm: Object {
    @Persisted var tempMin: Int
    @Persisted var tempMax: Int
    @Persisted var precProb: Int
}

class HoursRealm: Object {
    @Persisted var hour: String
    @Persisted var temp: Int
    @Persisted var condition: String
}




















//
//class FactRealmModel: Object {
//    @Persisted var temp: Int = 0
//    @Persisted var feelsLike: Int = 0
//    
//    convenience init(temp: Int, feelsLike: Int) {
//        self.init()
//        self.temp = temp
//        self.feelsLike = feelsLike
//    }
//}
//
//class ForecastsRealmModel: Object {
//    @Persisted var sunrise: String = ""
//    
//    convenience init(sunrise: String) {
//        self.init()
//        self.sunrise = sunrise
//    }
//}
//
//extension WeatherRealmModel {
//    convenience init(from networkModel: WeatherNetworkModel) {
//        self.init()
//        
//        self.nowDt = networkModel.nowDt
//        self.fact = FactRealmModel(temp: networkModel.fact.temp, feelsLike: networkModel.fact.feelsLike)
//        
//        self.forecasts.removeAll()
//        for forecast in networkModel.forecasts {
//            let realmForecast = ForecastsRealmModel(sunrise: forecast.sunrise)
//            self.forecasts.append(realmForecast)
//        }
//    }
//}
