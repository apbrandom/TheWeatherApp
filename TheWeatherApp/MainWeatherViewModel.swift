//
//  MainWeatherViewModel.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 13.09.2023.
//

import Foundation
import Combine

class MainWeatherViewModel {
    
    @Published var weatherModel: WeatherModel?
    var weatherModelUpdate: AnyPublisher<WeatherModel?, Never> {
        $weatherModel.eraseToAnyPublisher()
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
                
                // Обновляем weatherModel
                self.weatherModel = WeatherModel(from: databaseModel)
                print(weatherModel ?? "No data weatherModel")
            } catch {
                print("Error fetching weather: \(error)")
                // Здесь пытаемся загрузить данные из CoreData
                if let lastSavedWeather = coreDataService.fetchCachedWeather() {
                    self.weatherModel = WeatherModel(from: lastSavedWeather)
                }
            }
        }
    }
    
    // Используем Combine для обработки обновлений weatherModel
        func startObservingWeatherModelUpdates() {
            self.$weatherModel
                .sink { updatedWeatherModel in
                    // Здесь обрабатываем обновление модели
                }
                .store(in: &cancellables)
        }

    func getFixedHeightSubviews() -> CGFloat {
        return fixedHeightSubviews
    }
    
    func getNumberOfSubviews() -> CGFloat {
        return numberOfSubviews
    }
}


