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
      characterNameLabel.font = UIFont.cardTitle()
      characterAlterEgoLabel.font = UIFont.cardSubtitle()
  }

  func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}
