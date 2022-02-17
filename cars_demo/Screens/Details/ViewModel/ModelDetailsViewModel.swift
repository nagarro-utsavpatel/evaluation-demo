//
//  ModelDetailsViewModel.swift
//  cars_demo
//
//  Created by Utsav Patel on 16/02/2022.
//

import Foundation
import UIKit

class ModelDetailsViewModel {
    let apiService: EdmundsClient
    let selectedModel: ModelCellViewModel

    private var modelList = [ModelStyles]()

    weak var appCoordinator: ModelDetailsCoordinator!

    private var cellViewModels: [StyleDetailsList] = [StyleDetailsList]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }

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

    var name: String {
        return selectedModel.name
    }

    var reloadTableViewClosure: (() -> Void)?
    var showAlertClosure: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?

    init( apiService: EdmundsClient, model: ModelCellViewModel) {
        self.apiService = apiService
        self.selectedModel = model
    }

    func backToMoldes() {
        appCoordinator.popToParent()
    }

    func initFetch() {
        self.isLoading = true

        apiService.request(requestType: Client.style(makeNiceName: selectedModel.makeName,
                                                     niceName: selectedModel.modelName),
                           type: Response<ModelStyles>.self) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let items):
                self?.processFetchedItem(items: items.results)
            // swiftlint:disable empty_enum_arguments
            case .failure(_):
                self?.alertMessage = "No any data found!"
            }
        }
    }

    func getCellViewModel( at indexPath: IndexPath ) -> StyleDetailsList {
        return cellViewModels[indexPath.row]
    }

    private func processFetchedItem(items: [ModelStyles] ) {
        self.modelList = items // Cache
        var vms = [StyleDetailsList]()
        for item in modelList {
            var singleItem = StyleDetailsList()
            let enginType = "\(item.engineType ?? "No EngineType") / Size:\(item.engineSize ?? 3300)cc"
            let transmissionType = item.transmissionType ?? "Automatic"
            singleItem.engineTypeSize = StyleDetails(detailType: .text,
                                                     text: (.engineTypeSize, enginType))
            singleItem.transmissionType = StyleDetails(detailType: .text,
                                                       text: (.transmissionType, transmissionType))
            singleItem.vehicleStyleSize = StyleDetails(detailType: .text,
                                                       text: (.vehicleStyleSize, "Car"))
            singleItem.numberOfSeats = StyleDetails(detailType: .text,
                                                    text: (.numberOfSeats, "Seats: 4"))
            singleItem.colors = StyleDetails(detailType: .color, colors: (.colors, [.red, .blue, .gray, .green]))
            singleItem.photoI = StyleDetails(detailType: .photo, images: [])
            singleItem.photoE = StyleDetails(detailType: .photo, images: [])
            vms.append( singleItem )
        }
        self.cellViewModels = vms
    }
}

extension ModelDetailsViewModel {
    func userPressed( at indexPath: IndexPath ) {
    }
}

struct StyleDetailsList {
    var engineTypeSize: StyleDetails!
    var transmissionType: StyleDetails!
    var vehicleStyleSize: StyleDetails!
    var numberOfSeats: StyleDetails!
    var colors: StyleDetails!
    var photoI: StyleDetails!
    var photoE: StyleDetails!
}

struct StyleDetails {
    let detailType: DetailsType
    let images: [UIImage]?
    let text: (Titles, String)?
    let colors: (Titles, [UIColor])?

    enum DetailsType {
        case text, color, photo
    }

    enum Titles: String {
        case engineTypeSize = "Engine Type/Size"
        case transmissionType = "Transmission Type"
        case vehicleStyleSize = "Vehicle Style/Size"
        case numberOfSeats = "Number Of Seats"
        case colors = "Colors"
        case photoI = "PhotoI"
        case photoE = "PhotoE"
    }

    init(detailType: DetailsType,
         images: [UIImage]? = nil,
         text: (Titles, String)? = nil,
         colors: (Titles, [UIColor])? = nil) {
        self.text = text
        self.detailType = detailType
        self.images = images
        self.colors = colors
    }
}
