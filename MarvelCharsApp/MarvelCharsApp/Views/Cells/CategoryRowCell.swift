//
//  CategoryRowCell.swift
//  MarvelCharsApp
//
//  Created by admin on 11/26/21.
//

import UIKit

protocol CharacterPortraitDelegate {
  func onTappedCharacter(character: CharacterModel)
  func showCategoryView(category: CategoryModel)
}

class CategoryRowCell: UITableViewCell {
  
  @IBOutlet weak var categoryNameLabel: UILabel!
  @IBOutlet weak var charactersCollectionView: UICollectionView!
  @IBOutlet weak var seeAllButton: UIButton!
  
  var delegate: CharacterPortraitDelegate?
  var category: CategoryModel?
  let loader = ImageLoader()
  
  private let collectionViewCellNibName = "CharacterPortraitCell"
  private let cellReuseIdentifier = "CharacterPortraitID"
  
  func configure(category: CategoryModel?){
    self.category = category
    self.categoryNameLabel.text = category?.category
    refresh()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.selectionStyle = .none
    
    charactersCollectionView.register(UINib(nibName: self.collectionViewCellNibName, bundle: nil), forCellWithReuseIdentifier: self.cellReuseIdentifier)
    charactersCollectionView.dataSource = self
    charactersCollectionView.delegate = self
    
    categoryNameLabel.textColor = UIColor.primary_red
    categoryNameLabel.font = UIFont.sectionTitle()
    seeAllButton.titleLabel?.textColor = UIColor.primary_grey
    seeAllButton.titleLabel?.tintColor = UIColor.primary_grey
    seeAllButton.titleLabel?.font = UIFont.description()
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
    if let safeCharacterCount = self.category?.charactersCount {
      return safeCharacterCount < 4 ? safeCharacterCount : 4
    }
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = charactersCollectionView.dequeueReusableCell(withReuseIdentifier: self.cellReuseIdentifier, for: indexPath) as? CharacterPortraitCell else {
      return UICollectionViewCell()
    }
    if let character = self.category?.getCharacter(at: indexPath.row) {
      cell.characterNameLabel.text = character.name
      cell.characterAlterEgoLabel.text = character.alterEgo
      guard let url = URL(string: character.imagePath) else {
        cell.characterImage.image = UIImage(systemName: "placeholdertext.fill")
        return cell
      }
      // 1
      let token = loader.loadImage(url) { result in
        do {
          // 2
          let image = try result.get()
          // 3
          DispatchQueue.main.async {
            cell.characterImage.image = image
            //cell.characterImage.image = image.roundedImage
            DispatchQueue.main.async {
              cell.dropShadow(color: image.averageColor ?? .clear)
            }
            
          }
        } catch {
          // 4
          print(error)
        }
      }

      // 5
      cell.onReuse = {
        if let token = token {
          self.loader.cancelLoad(token)
        }
      }
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

