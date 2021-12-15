//
//  GradientView.swift
//  MarvelCharsApp
//
//  Created by User on 12/15/21.
//

import Foundation
import UIKit

class GradientView: UIView {

    let gradientLayer = CAGradientLayer()
    let startColor = UIColor.clear.cgColor
    let endColor = UIColor.black.cgColor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [startColor, endColor]
        gradientLayer.locations = [0, 0.7]
        self.layer.addSublayer(gradientLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
}
