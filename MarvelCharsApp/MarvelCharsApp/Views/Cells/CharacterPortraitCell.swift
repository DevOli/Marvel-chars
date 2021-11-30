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
