//
//  MainWeatherViewModel.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 13.09.2023.
//

import Foundation

class MainWeatherViewModel {
    private var weather: WeatherModel?
    private let networkService: NetworkService
    internal var fixedHeightSubviews: CGFloat = 0.0
    private let numberOfSubviews: CGFloat = 3.0
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func fetchWeather() async {
        do {
            let weatherData = try await networkService.fetchData()
            self.weather = weatherData
            print(weatherData.fact)
        } catch {
            print("Error fetching weather: \(error)")
        }
    }
    
    func getFixedHeightSubviews() -> CGFloat {
        return fixedHeightSubviews
    }
    
    func getNumberOfSubviews() -> CGFloat {
        return numberOfSubviews
    }
}












//    var temperatureText: String? {
//        guard let weather = weather else { return nil }
//        return "\(weather)°C"
//    }
//
