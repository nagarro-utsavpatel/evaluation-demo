//
//  ApplicationCoordinator.swift
//  cars_demo
//
//  Created by Utsav Patel on 15/02/2022.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    var parentCoordinator: Coordinator?

    var children: [Coordinator] = []

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        log.info("AppCoordinator Start")
        let authCoordinator = SelectMakeCoordinator(navigationController: navigationController)
        authCoordinator.parentCoordinator = self
        children.append(authCoordinator)

        authCoordinator.start()
    }
}
