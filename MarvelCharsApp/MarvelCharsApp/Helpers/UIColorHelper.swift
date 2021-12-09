//
//  UIColorHelper.swift
//  MarvelCharsApp
//
//  Created by admin on 11/30/21.
//

import Foundation
import UIKit
extension UIColor {
  static let primary_grey = UIColor(rgb: 0xB7B7C8)
  static let primary_red = UIColor(rgb: 0xF2264B)
  static let primary_black = UIColor(rgb: 0x000000)
  static let primary_white = UIColor(rgb: 0xFFFFFF)
  static let primary_dark = UIColor(rgb: 0x313140)
  static let primary_silver = UIColor(rgb: 0xF8F8F8)
  static let gradient_blue_a = UIColor(rgb: 0x005BEA)
  static let gradient_blue_b = UIColor(rgb: 0x00C6FB)
  static let gradient_red_a = UIColor(rgb: 0xED1D24)
  static let gradient_red_b = UIColor(rgb: 0xED1F69)
  static let gradient_purple_a = UIColor(rgb: 0xB224EF)
  static let gradient_purple_b = UIColor(rgb: 0x7579FF)
  static let gradient_green_a = UIColor(rgb: 0x0BA360)
  static let gradient_green_b = UIColor(rgb: 0x3CBA92)
  static let gradient_pink_a = UIColor(rgb: 0xFF7EB3)
  static let gradient_pink_b = UIColor(rgb: 0xFF758C)
    
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
