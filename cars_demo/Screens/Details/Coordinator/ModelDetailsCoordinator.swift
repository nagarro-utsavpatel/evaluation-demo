//
//  ModelDetailsCoordinator.swift
//  cars_demo
//
//  Created by Utsav Patel on 16/02/2022.
//

import UIKit

class ModelDetailsCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?

    let model: ModelCellViewModel

    var children: [Coordinator] = []

    var navigationController: UINavigationController

    init(navigationController: UINavigationController, make: ModelCellViewModel) {
        self.navigationController = navigationController
        self.model = make
    }

    func start() {
        log.info("SelectMakeCoordinator Start")

        let controller = ModelDetailsScreen.instantiateFromStoryboard()

        let viewModel = ModelDetailsViewModel(apiService: EdmundsClient(), model: model)
        viewModel.appCoordinator = self
        controller.viewModel = viewModel
        navigationController.pushViewController(controller, animated: true)
    }
}

extension ModelDetailsCoordinator {
    func popToParent() {
        navigationController.popViewController(animated: true)
    }
}
