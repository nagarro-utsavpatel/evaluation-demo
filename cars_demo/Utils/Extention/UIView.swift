//
//  UIView.swift
//  cars_demo
//
//  Created by Utsav Patel on 16/02/22.
//

import UIKit

extension UIView {
    func setStyles(shadowRadius: CGFloat = 10,
                   cornerRadius: CGFloat = 16,
                   shadowColor: UIColor = UIColor.black,
                   shadowOpacity: Float = 0.8) {
        layer.cornerRadius = cornerRadius

        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}
