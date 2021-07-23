//
//  MainCoordinator.swift
//  Airbnb
//
//  Created by Ador on 2021/07/14.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func show()
    func dismiss()
}

extension Coordinator {
    func dismiss() {
        navigationController.popViewController(animated: true)
    }
}

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        childCoordinators = [ResultCoordinator(navigationController: navigationController)]
    }

    func show() {
        let vc = CalendarViewController.instantiate()
//        vc.coordinator = childCoordinators.first
        navigationController.pushViewController(vc, animated: true)
    }
}

class ResultCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        childCoordinators = [DetailCoordinator(navigationController: navigationController)]
        self.navigationController = navigationController
    }
    
    func show() {
        let vc = DetailViewController.instantiate()
        vc.coordinator = childCoordinators.first
        navigationController.pushViewController(vc, animated: true)
    }
}

class DetailCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func show() { }
}
