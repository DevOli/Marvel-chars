//
//  UIImageHelper.swift
//  MarvelCharsApp
//
//  Created by admin on 11/30/21.
//

import Foundation
import UIKit

extension UIImage{
  var roundedImage: UIImage{
    let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: self.size)
    UIGraphicsBeginImageContextWithOptions(self.size, false, 1)
    UIBezierPath(roundedRect: rect, cornerRadius: 25).addClip()
    self.draw(in: rect)
    return UIGraphicsGetImageFromCurrentImageContext()!
  }
}
