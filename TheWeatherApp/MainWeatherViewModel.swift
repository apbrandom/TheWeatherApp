//
//  MainWeatherViewModel.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 13.09.2023.
//

import Foundation

class MainWeatherViewModel {
    private var weather: Weather
    internal var fixedHeightSubviews: CGFloat = 0.0
    private let numberOfSubviews: CGFloat = 3.0
    
    var temperatureText: String {
        return "\(weather.temperature)°C"
    }
    
    init(weather: Weather) {
        self.weather = weather
    }
    
    func getFixedHeightSubviews() -> CGFloat {
        return fixedHeightSubviews
    }
    
    func getNumberOfSubviews() -> CGFloat {
        return numberOfSubviews
    }
}

