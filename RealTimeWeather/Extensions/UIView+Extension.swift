//
//  UIView+Extension.swift
//  RealTimeWeather
//
//  Created by Pavan Thakkar on 24/08/23.
//

import UIKit

extension UIView {
    func dropShadow(scale: Bool = true) {
       
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowRadius = 2
    }
}

