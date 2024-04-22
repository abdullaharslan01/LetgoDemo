//
//  Button+Radious.swift
//  SellGo
//
//  Created by abdullah on 22.04.2024.
//

import UIKit

extension UIButton {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            clipsToBounds = true
        }
    }
}
