//
//  CharacterPortraitCell.swift
//  MarvelCharsApp
//
//  Created by admin on 11/25/21.
//

import UIKit

class CharacterPortraitCell: UICollectionViewCell {
  @IBOutlet var characterImage: UIImageView!
  @IBOutlet var characterNameLabel: UILabel!
  @IBOutlet var characterAlterEgoLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
      characterNameLabel.font = UIFont.cardTitle()
      characterAlterEgoLabel.font = UIFont.cardSubtitle()
  }

  func dropShadow(color: UIColor) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = 0.7
    layer.shadowOffset = CGSize(width: 0, height: 8)
    layer.shadowRadius = 6
    layer.shouldRasterize = true
    layer.rasterizationScale = UIScreen.main.scale
  }
}
