//
//  MainWeatherViewModel.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 13.09.2023.
//

import Foundation
import Combine

class MainWeatherViewModel {
    
    @Published var weatherModel: WeatherViewModel?
    var weatherModelUpdate: AnyPublisher<WeatherViewModel?, Never> {
        $weatherModel.eraseToAnyPublisher()
    }
    
    private var cancellables = Set<AnyCancellable>()

    private let networkService: NetworkService
    private let realmService: RealmService
    
    internal var fixedHeightSubviews: CGFloat = 0.0
    private let numberOfSubviews: CGFloat = 3.0
    
    init(networkService: NetworkService, realmService: RealmService ) {
        self.networkService = networkService
        self.realmService = realmService
    }
    
    func fetchWeather() async {
        Task {
            do {
                let networkModel = try await networkService.fetchNetworkModel()
                
                let realmModel = mapToRealmModel(networkModel: networkModel) // Преобразование модели
                
                do {
                    try await realmService.saveOrUpdateWeather(realmModel)
                } catch {
                    print("Failed to save or update in Realm: \(error)")
                }
                
                updateWeatherModel(from: realmModel)
            } catch {
                print("Error fetching weather: \(error)")
            }
        }
    }
    
    private func mapToRealmModel(networkModel: WeatherNetworkModel) -> WeatherRealmModel {
        let factRealmModel = FactRealmModel(temp: networkModel.fact.temp)
        let realmModel = WeatherRealmModel(nowDt: networkModel.nowDt)
        realmModel.fact = factRealmModel
        return realmModel
    }


    private func updateWeatherModel(from realmModel: WeatherRealmModel) {
        // Обновление ViewModel
        DispatchQueue.main.async { [weak self] in // Переключаемся на главный поток
            let factVM = FactViewModel(temp: realmModel.fact?.temp ?? 0)
            self?.weatherModel = WeatherViewModel(nowDt: realmModel.nowDt, fact: factVM)
        }
    }



    func getFixedHeightSubviews() -> CGFloat {
        return fixedHeightSubviews
    }
    
    func getNumberOfSubviews() -> CGFloat {
        return numberOfSubviews
    }
}



