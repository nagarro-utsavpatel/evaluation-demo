//
//  SelectMake.swift
//  cars_demo
//
//  Created by Utsav Patel on 15/02/2022.
//

import Foundation

struct MakeModel: Codable {
    var id: Int
    var name: String
    var niceName: String
    var adTargetId: String
    var niceId: String
    var useInUsed: String
    var useInNew: String
    var useInPreProduction: String
    var useInFuture: String
    var models: [Models] = []

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case niceName
        case adTargetId
        case niceId
        case useInUsed
        case useInNew
        case useInPreProduction
        case useInFuture
        case models
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        niceName = try values.decodeIfPresent(String.self, forKey: .niceName) ?? ""
        adTargetId = try values.decodeIfPresent(String.self, forKey: .adTargetId) ?? ""
        niceId = try values.decodeIfPresent(String.self, forKey: .niceId) ?? ""
        useInUsed = try values.decodeIfPresent(String.self, forKey: .useInUsed) ?? ""
        useInNew = try values.decodeIfPresent(String.self, forKey: .useInNew) ?? ""
        useInPreProduction = try values.decodeIfPresent(String.self, forKey: .useInPreProduction) ?? ""
        useInFuture = try values.decodeIfPresent(String.self, forKey: .useInFuture) ?? ""
        models = try values.decodeIfPresent([Models].self, forKey: .models) ?? []
    }
}

struct Models: Codable {
    var id: String
    var name: String
    var niceName: String
    var href: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case niceName
        case href
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        niceName = try values.decodeIfPresent(String.self, forKey: .niceName) ?? ""
        href = try values.decodeIfPresent(String.self, forKey: .href) ?? ""
    }
}
