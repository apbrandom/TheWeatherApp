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
    
    
//    private let coreDataStack = CoreDataStack()
//
//       func fetchWeather() async {
//           do {
//               let weatherData = try await networkService.fetchData()
//               self.weather = weatherData
//               coreDataStack.saveWeatherToCache(weather: weatherData)
//               print("Fetched and saved to CoreData:", weatherData)
//           } catch {
//               print("Error fetching weather from API: \(error)")
//               if let cachedWeather = coreDataStack.fetchCachedWeather() {
//                   self.weather = cachedWeather
//                   print("Fetched from CoreData:", cachedWeather)
//               }
//           }
//       }

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
