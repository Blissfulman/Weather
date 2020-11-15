//
//  Extension + UIView.swift
//  Weather
//
//  Created by User on 15.11.2020.
//

import UIKit

extension UIView {
    
    func setupViewGradient(withColors colors: [CGColor], opacity: Float) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.opacity = opacity
        gradientLayer.frame = self.frame
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
