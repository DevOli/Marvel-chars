//
//  CategoryRowCell.swift
//  MarvelCharsApp
//
//  Created by admin on 11/26/21.
//

import UIKit

protocol CategoryRowCellDelegate {
  func onTappedCharacter(character: CharacterModel)
  func showCategoryView(category: CategoryModel)
}

class CategoryRowCell: UITableViewCell {
  
  @IBOutlet weak var categoryNameLabel: UILabel!
  @IBOutlet weak var charactersCollectionView: UICollectionView!
  @IBOutlet weak var seeAllButton: UIButton!
  
  var delegate: CategoryRowCellDelegate?
  var category: CategoryModel?
  
  func configure(category: CategoryModel?){
    self.category = category
    self.categoryNameLabel.text = category?.category
    refresh()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.selectionStyle = .none
    
    charactersCollectionView.register(UINib(nibName: "CharacterPortraitCell", bundle: nil), forCellWithReuseIdentifier: "CharacterPortraitID")
    charactersCollectionView.dataSource = self
    charactersCollectionView.delegate = self
    
    categoryNameLabel.textColor = UIColor.primary_red
    seeAllButton.titleLabel?.textColor = UIColor.primary_grey
    seeAllButton.titleLabel?.tintColor = UIColor.primary_grey
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0))
  }
  
  @IBAction func onSeeAllButtonTapped(_ sender: UIButton) {
    if let category = self.category {
      self.delegate?.showCategoryView(category: category)
    }
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
    return self.category?.charactersCount ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = charactersCollectionView.dequeueReusableCell(withReuseIdentifier: "CharacterPortraitID", for: indexPath) as! CharacterPortraitCell
    if let character = self.category?.getCharacter(at: indexPath.row) {
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
    if let category = self.category, let character = category.getCharacter(at: indexPath.row) {
      self.delegate?.onTappedCharacter(character: character)
    }
  }
}
