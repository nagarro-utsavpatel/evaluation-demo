//
//  ModelCellViewModel.swift
//  cars_demo
//
//  Created by Utsav Patel on 16/02/2022.
//

import Foundation

struct ModelCellViewModel {
    private let model: Model
    var name: String {
        return model.name
    }

    var makeName: String {
        return model.makeNiceName
    }

    var modelName: String {
        return model.niceName
    }

    init(model: Model) {
        self.model = model
    }
}
