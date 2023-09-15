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
    var networkService: NetworkService

    init(navigationController: UINavigationController, networkService: NetworkService) {
        self.navigationController = navigationController
        self.childCoordinators = []
        self.networkService = networkService
    }

    func start() {
        let viewModel = MainWeatherViewModel(networkService: networkService)
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
