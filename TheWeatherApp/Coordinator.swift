//
//  Coordinator.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 13.09.2023.
//

import Foundation
import UIKit

// MARK: - Coordinator Protocol
protocol Coordinator {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    func start()
}

// MARK: - Main Coordinator
class MainCoordinator: Coordinator {
    
    // MARK: - Properties
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator]
    var networkService: NetworkService
    var realmService: RealmService
    var modelConverter: ModelConverter
    
    // MARK: - Initializer
    init(navigationController: UINavigationController, networkService: NetworkService, realmService: RealmService, modelConverter: ModelConverter) {
        self.navigationController = navigationController
        self.childCoordinators = []
        self.networkService = networkService
        self.realmService = realmService
        self.modelConverter = modelConverter
    }
    
    // MARK: - Start Main Flow
    func start() {
        let viewModel = WeatherViewModel(networkService: networkService, realmService: realmService, modelConverter: modelConverter)
        let viewController = MainWeatherViewController(viewModel: viewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Show Detail Weather View
    func showDetail() {
        let viewModel = WeatherViewModel(networkService: networkService, realmService: realmService, modelConverter: modelConverter)
        let detailViewController = DetailWeatherViewController(viewModel: viewModel)
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
}
