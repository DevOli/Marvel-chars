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
