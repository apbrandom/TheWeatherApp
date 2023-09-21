//
//  WeatherRealmModel.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 21.09.2023.
//

import RealmSwift

class WeatherRealmModel: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var nowDt: String = ""
    @Persisted var fact: FactRealmModel?
    
    convenience init(nowDt: String) {
        self.init()
        self.nowDt = nowDt
    }
}

class FactRealmModel: Object {
    @Persisted var temp: Int = 0
    
    convenience init(temp: Int) {
        self.init()
        self.temp = temp
    }
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
