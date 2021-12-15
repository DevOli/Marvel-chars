//
//  UIColor.swift
//  MarvelCharsApp
//
//  Created by admin on 11/30/21.
//

import Foundation
import UIKit
extension UIColor {
  static let gradientBlueA = UIColor(named: "gradient-blue-a") ?? .blue
  static let gradientBlueB = UIColor(named: "gradient-blue-b") ?? .blue
  static let gradientGreenA = UIColor(named: "gradient-green-a") ?? .green
  static let gradientGreenB = UIColor(named: "gradient-green-b") ?? .green
  static let gradientPinkA = UIColor(named: "gradient-pink-a") ?? .red
  static let gradientPinkB = UIColor(named: "gradient-pink-b") ?? .red
  static let gradientPurpleA = UIColor(named: "gradient-purple-a") ?? .blue
  static let gradientPurpleB = UIColor(named: "gradient-purple-b") ?? .blue
  static let gradientRedA = UIColor(named: "gradient-red-a") ?? .red
  static let gradientRedB = UIColor(named: "gradient-red-b") ?? .red
  static let primaryBlack = UIColor(named: "primary-black") ?? .black
  static let primaryDark = UIColor(named: "primary-dark") ?? .darkGray
  static let primaryGrey = UIColor(named: "primary-grey") ?? .gray
  static let primaryRed = UIColor(named: "primary-red") ?? .red
  static let primarySilver = UIColor(named: "primary-silver") ?? .white
  static let primaryWhite: UIColor = UIColor(named: "primary-white") ?? .white
    convenience init(rgb: Int) {
      self.init(
        red: (rgb >> 16) & 0xFF,
        green: (rgb >> 8) & 0xFF,
        blue: rgb & 0xFF
      )
    }
    convenience init(red: Int, green: Int, blue: Int) {
      self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}
