//
//  UIColor.swift
//  MarvelCharsApp
//
//  Created by admin on 11/30/21.
//

import Foundation
import UIKit
extension UIColor {
  static let primaryGrey = UIColor(rgb: 0xB7B7C8)
  static let primaryRed = UIColor(rgb: 0xF2264B)
  static let primaryBlack = UIColor(rgb: 0x000000)
  static let primaryWhite = UIColor(rgb: 0xFFFFFF)
  static let primaryDark = UIColor(rgb: 0x313140)
  static let primarySilver = UIColor(rgb: 0xF8F8F8)
  static let gradientBlueA = UIColor(rgb: 0x005BEA)
  static let gradientBlueB = UIColor(rgb: 0x00C6FB)
  static let gradientRedA = UIColor(rgb: 0xED1D24)
  static let gradientRedB = UIColor(rgb: 0xED1F69)
  static let gradientPurpleA = UIColor(rgb: 0xB224EF)
  static let gradientPurpleB = UIColor(rgb: 0x7579FF)
  static let gradientGreenA = UIColor(rgb: 0x0BA360)
  static let gradientGreenB = UIColor(rgb: 0x3CBA92)
  static let gradientPinkA = UIColor(rgb: 0xFF7EB3)
  static let gradientPinkB = UIColor(rgb: 0xFF758C)

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
