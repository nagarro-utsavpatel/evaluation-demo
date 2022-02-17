//
//  SelectMakeCoordinator.swift
//  cars_demo
//
//  Created by Utsav Patel on 15/02/2022.
//
import Foundation
import UIKit

class SelectMakeCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?

    var children: [Coordinator] = []

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        log.info("SelectMakeCoordinator Start")

        let controller = SelectMakeScreen.instantiateFromStoryboard()

        let viewModel = MakeViewModel(apiService: EdmundsClient())
        viewModel.appCoordinator = self
        controller.viewModel = viewModel
        navigationController.pushViewController(controller, animated: true)
    }
}

extension SelectMakeCoordinator {
    func movetoSelectModel(model: MakeCellViewModel) {
        let selectModelCoordinator = SelectModelCoordinator(navigationController: navigationController,
                                                            make: model)
        selectModelCoordinator.parentCoordinator = self
        children.append(selectModelCoordinator)

        selectModelCoordinator.start()
    }
}
