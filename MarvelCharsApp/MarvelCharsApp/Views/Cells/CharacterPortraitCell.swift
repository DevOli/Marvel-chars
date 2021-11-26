//
//  CharacterPortraitCell.swift
//  MarvelCharsApp
//
//  Created by admin on 11/25/21.
//

import UIKit

class CharacterPortraitCell: UICollectionViewCell {
  
  
  @IBOutlet weak var characterImage: UIImageView!
  @IBOutlet weak var characterNameLabel: UILabel!
  @IBOutlet weak var characterAlterEgoLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
}

extension UIImage{
  var roundedImage: UIImage{
    let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: self.size)
    UIGraphicsBeginImageContextWithOptions(self.size, false, 1)
    UIBezierPath(roundedRect: rect, cornerRadius: 50).addClip()
    self.draw(in: rect)
    return UIGraphicsGetImageFromCurrentImageContext()!
  }
}
