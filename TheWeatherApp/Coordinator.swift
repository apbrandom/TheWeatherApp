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
    var coreDataService: CoreDataService

    init(navigationController: UINavigationController, networkService: NetworkService, coreDataService: CoreDataService) {
        self.navigationController = navigationController
        self.childCoordinators = []
        self.networkService = networkService
        self.coreDataService = coreDataService
    }

    func start() {
        let viewModel = MainWeatherViewModel(networkService: networkService, coreDataService: coreDataService)
        let viewController = MainWeatherViewController(viewModel: viewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showDetail() {
        let detailViewModel = DetailWeatherViewModel()
        let detailViewController = DetailWeatherViewController(viewModel: detailViewModel)
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
//    func childDidFinish(_ child: Coordinator?) {
//            for (index, coordinator) in childCoordinators.enumerated() where coordinator === child {
//                childCoordinators.remove(at: index)
//                break
//            }
//        }
}
