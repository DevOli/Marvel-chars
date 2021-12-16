//  UIButtonHelper.swift
//  MarvelCharsApp
//
//  Created by User on 7/12/21.
//

import Foundation
import UIKit

extension UIButton {
    func applyGradient(colours: [UIColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        self.layer.insertSublayer(gradient, at: 0)
    }
    func buttonTitleStyles(colours: [UIColor]) {
        let button = self
        button.applyGradient(colours: colours)
        button.tintColor = UIColor.primaryWhite
        button.layer.masksToBounds = true
        button.layer.cornerRadius = button.frame.width / 2
    }
}
