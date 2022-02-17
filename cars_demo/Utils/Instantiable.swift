//
//  Instantiable.swift
//  cars_demo
//
//  Created by Utsav Patel on 15/02/2022.
//

import UIKit

protocol StringConvertible {
    var rawValue: String { get }
}

protocol Instantiable: AnyObject {
    static var storyboardName: StringConvertible { get }
}

extension Instantiable {
    static func instantiateFromStoryboard() -> Self {
        return instantiateFromStoryboardHelper()
    }

    private static func instantiateFromStoryboardHelper<T>() -> T {
        let identifier = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        // swiftlint:disable force_cast
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }

    // default Main storyboard, you can add more and inmplemnt in your own viewcontroller
    static var storyboardName: StringConvertible {
        return StoryboardName.main
    }
}

extension String: StringConvertible {
    var rawValue: String {
        return self
    }
}

enum StoryboardName: String, StringConvertible {
    case main = "Main"
}
