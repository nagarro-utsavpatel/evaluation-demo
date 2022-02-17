//
//  ModelViewModel.swift
//  cars_demo
//
//  Created by Utsav Patel on 16/02/2022.
//

import Foundation

class ModelViewModel {
    let apiService: EdmundsClient
    let selectedMake: MakeCellViewModel

    private var modelList = [Model]()

    weak var appCoordinator: SelectModelCoordinator!

    private var cellViewModels: [ModelCellViewModel] = [ModelCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }

    var year = 2022

    var isLoading = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }

    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }

    var numberOfCells: Int {
        return cellViewModels.count
    }

    var reloadTableViewClosure: (() -> Void)?
    var showAlertClosure: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?

    init( apiService: EdmundsClient, make: MakeCellViewModel) {
        self.apiService = apiService
        self.selectedMake = make
    }

    func backToMake() {
        appCoordinator.popToParent()
    }

    func initFetch() {
        self.isLoading = true
        apiService.request(requestType: Client.models(year: year,
                                                      makeNiceName: selectedMake.niceName),
                           type: Response<Model>.self) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let items):
                if items.results.isEmpty {
                    self?.alertMessage = "No models available"
                } else {
                    self?.processFetchedItem(items: items.results)
                }
            // swiftlint:disable empty_enum_arguments
            case .failure(_):
                self?.alertMessage = "No any data found!"
            }
        }
    }

    func getCellViewModel(at indexPath: IndexPath) -> ModelCellViewModel {
        return cellViewModels[indexPath.row]
    }

    private func processFetchedItem(items: [Model]) {
        self.modelList = items // Cache
        var vms = [ModelCellViewModel]()
        for item in modelList {
            vms.append(ModelCellViewModel(model: item))
        }
        self.cellViewModels = vms
    }
}

extension ModelViewModel {
    func userPressed(at indexPath: IndexPath) {
        appCoordinator.movetoDetails(model: getCellViewModel(at: indexPath))
    }
}
