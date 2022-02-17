//
//  Constants.swift
//  cars_demo
//
//  Created by Utsav Patel on 15/02/2022.
//

import Foundation
import UPLogs

// Logger
let log = UPLogs()

// Constans
struct Constants {
    private init() {}

    // Applicaiton Shared Secret Key
    static var appApiKey: String {
        return Bundle.valueFor(key: "SECREAT_KEY")
    }

    // Get from configuration
    static var baseURL: String {
        return "https://\(Bundle.valueFor(key: "API_URL"))"
    }
}

fileprivate extension Bundle {
    static func valueFor(key: String) -> String {
        // swiftlint:disable force_cast
        return Bundle.main.object(forInfoDictionaryKey: key) as! String
    }
}
