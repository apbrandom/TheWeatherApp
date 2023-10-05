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
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator]
    var networkService: NetworkService
    var realmService: RealmService
    var modelConverter: ModelConverter

    init(navigationController: UINavigationController, networkService: NetworkService, realmService: RealmService, modelConverter: ModelConverter) {
        self.navigationController = navigationController
        self.childCoordinators = []
        self.networkService = networkService
        self.realmService = realmService
        self.modelConverter = modelConverter
    }

    func start() {
        let viewModel = MainWeatherViewModel(networkService: networkService, realmService: realmService, modelConverter: modelConverter)
        let detailViewModel = DetailWeatherViewModel()
        let viewController = MainWeatherViewController(viewModel: viewModel, viewModelDetail: detailViewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showDetail() {
        let detailViewModel = DetailWeatherViewModel()
        let detailViewController = DetailWeatherViewController(viewModel: detailViewModel)
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
}
