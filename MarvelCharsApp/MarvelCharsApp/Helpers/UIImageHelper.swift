//
//  UIImageHelper.swift
//  MarvelCharsApp
//
//  Created by User on 30/11/21.
//

import Foundation
import UIKit

extension UIImage {
  func tintedWithLinearGradientColors(colorsArr: [CGColor]) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
    guard let context = UIGraphicsGetCurrentContext() else {
      return UIImage()
    }
    context.translateBy(x: 0, y: self.size.height)
    context.scaleBy(x: 1, y: -1)

    context.setBlendMode(.normal)
    let rect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
    let colors = colorsArr as CFArray
    let space = CGColorSpaceCreateDeviceRGB()
    let gradient = CGGradient(colorsSpace: space, colors: colors, locations: nil)

    context.clip(to: rect, mask: self.cgImage!)
    context.drawLinearGradient(gradient!, start: CGPoint(x: 0, y: 0),
                               end: CGPoint(x: 0, y: self.size.height), options: .drawsAfterEndLocation)
    let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return gradientImage!
  }

  var roundedImage: UIImage {
    let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: self.size)
    UIGraphicsBeginImageContextWithOptions(self.size, false, 1)
    UIBezierPath(roundedRect: rect, cornerRadius: 60).addClip()
    self.draw(in: rect)
    return UIGraphicsGetImageFromCurrentImageContext()!
  }
  var averageColor: UIColor? {
          guard let cgImage = cgImage else { return nil }
          let size = CGSize(width: 40, height: 40)
          let width = Int(size.width)
          let height = Int(size.height)
          let totalPixels = width * height
          let colorSpace = CGColorSpaceCreateDeviceRGB()
          let bitmapInfo: UInt32 = CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue
          guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * 4, space: colorSpace, bitmapInfo: bitmapInfo) else { return nil }

          context.draw(cgImage, in: CGRect(origin: .zero, size: size))

          guard let pixelBuffer = context.data else { return nil }
          let pointer = pixelBuffer.bindMemory(to: UInt32.self, capacity: width * height)

          var totalRed = 0
          var totalBlue = 0
          var totalGreen = 0
          
          for x in 0 ..< width {
              for y in 0 ..< height {
                  let pixel = pointer[(y * width) + x]
                  let r = red(for: pixel)
                  let g = green(for: pixel)
                  let b = blue(for: pixel)
                  totalRed += Int(r)
                  totalBlue += Int(b)
                  totalGreen += Int(g)
              }
          }
          
          let averageRed: CGFloat = CGFloat(totalRed) / CGFloat(totalPixels)
          let averageGreen: CGFloat = CGFloat(totalGreen) / CGFloat(totalPixels)
          let averageBlue: CGFloat = CGFloat(totalBlue) / CGFloat(totalPixels)

          return UIColor(red: averageRed / 255.0, green: averageGreen / 255.0, blue: averageBlue / 255.0, alpha: 1.0)
      }
      
      private func red(for pixelData: UInt32) -> UInt8 {
          return UInt8((pixelData >> 16) & 255)
      }

      private func green(for pixelData: UInt32) -> UInt8 {
          return UInt8((pixelData >> 8) & 255)
      }

      private func blue(for pixelData: UInt32) -> UInt8 {
          return UInt8((pixelData >> 0) & 255)
      }
}
