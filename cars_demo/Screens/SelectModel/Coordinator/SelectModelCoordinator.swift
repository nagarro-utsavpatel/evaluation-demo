//
//  SelectModelCoordinator.swift
//  cars_demo
//
//  Created by Utsav Patel on 16/02/2022.
//

import UIKit

class SelectModelCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    let make: MakeCellViewModel

    var children: [Coordinator] = []

    var navigationController: UINavigationController

    init(navigationController: UINavigationController, make: MakeCellViewModel) {
        self.navigationController = navigationController
        self.make = make
    }

    func start() {
        log.info("SelectModelCoordinator Start")

        let controller = SelectModelScreen.instantiateFromStoryboard()

        let viewModel = ModelViewModel(apiService: EdmundsClient(), make: make)
        viewModel.appCoordinator = self
        controller.viewModel = viewModel
        navigationController.pushViewController(controller, animated: true)
    }
}

extension SelectModelCoordinator {
    func movetoDetails(model: ModelCellViewModel) {
        let selectModelCoordinator = ModelDetailsCoordinator(navigationController: navigationController,
                                                             make: model)
        selectModelCoordinator.parentCoordinator = self
        children.append(selectModelCoordinator)

        selectModelCoordinator.start()
    }

    func popToParent() {
        navigationController.popViewController(animated: true)
    }
}
