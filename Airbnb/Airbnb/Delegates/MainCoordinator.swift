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
}

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func show() {
        let vc = ResultViewController.instantiate()
        navigationController.pushViewController(vc, animated: true)
    }
}
