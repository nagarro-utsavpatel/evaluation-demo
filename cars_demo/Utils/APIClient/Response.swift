//
//  ServiceResponse.swift
//  cars_demo
//
//  Created by Utsav Patel on 15/02/2022.
//

import Foundation

struct Response<T: Codable>: Codable {
    var totalNumber: Int
    var totalPages: Int
    var results: [T]
}
