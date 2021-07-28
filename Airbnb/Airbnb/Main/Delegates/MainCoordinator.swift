//
//  MainCoordinator.swift
//  Airbnb
//
//  Created by Ador on 2021/07/14.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    func dismiss()
}

extension Coordinator {
    func dismiss() {
        navigationController.popViewController(animated: true)
    }
}

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = ViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func moveToSearch() {
        let vc: SearchViewController = SearchViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func moveToCalendar() {
        let vc: CalendarViewController = CalendarViewController.instantiate()
        navigationController.pushViewController(vc, animated: true)
    }
}
