//
//  UIImageView.swift
//  MarvelCharsApp
//
//  Created by admin on 12/16/21.
//

import Foundation
import UIKit
extension UIImageView {
  func loadImage(at url: URL, completionHandler: @escaping ()->Void) {
    UIImageLoader.loader.load(url, for: self, completionHandler: completionHandler)
  }

  func cancelImageLoad() {
    UIImageLoader.loader.cancel(for: self)
  }
}
