//
//  CategoryRowCell.swift
//  MarvelCharsApp
//
//  Created by admin on 11/26/21.
//

import UIKit

class CategoryRowCell: UITableViewCell {
  
  @IBOutlet weak var categoryNameLabel: UILabel!
  @IBOutlet weak var charactersCollectionView: UICollectionView!
  
  var viewModel: HomeViewModel?
  
  var category: String?
  
  func configure(category: String){
    self.category = category
    self.categoryNameLabel.text = category
    refresh()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    charactersCollectionView.register(UINib(nibName: "CharacterPortraitCell", bundle: nil), forCellWithReuseIdentifier: "CharacterPortraitID")
    charactersCollectionView.dataSource = self
    charactersCollectionView.delegate = self
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  private func refresh() {
    DispatchQueue.main.async {
      [weak self] in
      self?.charactersCollectionView.reloadData()
    }
  }
  
}

extension CategoryRowCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if let count = viewModel?.getCategoryWith(name: self.category ?? "")?.characters.count {
      return count
    }
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = charactersCollectionView.dequeueReusableCell(withReuseIdentifier: "CharacterPortraitID", for: indexPath) as! CharacterPortraitCell
    if let character = viewModel?.getCategoryWith(name: self.category ?? "")?.getCharacter(at: indexPath.row) {
      let image = UIImage(named: character.imagePath)
      cell.characterImage.image = image?.roundedImage
      cell.characterNameLabel.text = character.name
      cell.characterAlterEgoLabel.text = character.alterEgo
    }
    return cell
  }
  
}

extension CategoryRowCell: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    return
  }
}
