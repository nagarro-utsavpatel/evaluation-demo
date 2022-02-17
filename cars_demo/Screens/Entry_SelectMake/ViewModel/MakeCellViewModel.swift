//
//  SelectMakeCellViewModel.swift
//  cars_demo
//
//  Created by Utsav Patel on 15/02/22.
//

import Foundation

struct MakeCellViewModel {
    private let model: MakeModel
    var name: String {
        return model.name
    }

    var niceName: String {
        return model.niceName
    }

    init(model: MakeModel) {
        self.model = model
    }
}
