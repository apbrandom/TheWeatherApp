//
//  Coordinator.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 13.09.2023.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    func start()
}

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = []
    }

    func start() {
        let sampleWeather = Weather(temperature: 25, condition: "Sunny")
        let viewModel = MainWeatherViewModel(weather: sampleWeather)
        let viewController = MainWeatherViewController(viewModel: viewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showDetail() {
        let detailViewModel = DetailWeatherViewModel()
        let detailViewController = DetailWeatherViewController(viewModel: detailViewModel)
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
