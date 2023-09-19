//
//  MainWeatherViewModel.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 13.09.2023.
//

import Foundation
import Combine

class MainWeatherViewModel {
    
    @Published var temperatureText: String?

    @Published var weatherModel: WeatherModel? {
        didSet {

            }
        }
    
    
    private var cancellables = Set<AnyCancellable>()


    
    private let networkService: NetworkService
    private let coreDataService: CoreDataService
    
    internal var fixedHeightSubviews: CGFloat = 0.0
    private let numberOfSubviews: CGFloat = 3.0
    
    
    init(networkService: NetworkService, coreDataService: CoreDataService) {
        self.networkService = networkService
        self.coreDataService = coreDataService
    }
    
    // Асинхронная функция для запроса погоды из сети и сохранения её в CoreData
    func fetchWeather() async {
        Task {
            do {
                let networkModel = try await networkService.fetchNetworkModel()
                let databaseModel = WeatherDatabaseModel(from: networkModel)
                
                // Сохраняем данные в CoreData
                coreDataService.saveWeather(databaseModel)
                
                // Обновляем UI
                self.weatherModel = WeatherModel(from: databaseModel)
                print(weatherModel ?? "No data weatherModel")
            } catch {
                print("Error fetching weather: \(error)")
            }
        }
    }


    
    func getFixedHeightSubviews() -> CGFloat {
        return fixedHeightSubviews
    }
    
    func getNumberOfSubviews() -> CGFloat {
        return numberOfSubviews
    }
}


