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
}
