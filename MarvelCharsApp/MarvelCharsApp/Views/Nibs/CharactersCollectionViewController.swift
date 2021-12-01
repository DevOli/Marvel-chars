//
//  CharactersCollectionViewController.swift
//  MarvelCharsApp
//
//  Created by admin on 12/1/21.
//

import UIKit

class CharactersCollectionViewController: UICollectionViewController {
  
  var delegate: CategoryRowCellDelegate?
  var category: CategoryModel?
  
  func configure(category: CategoryModel?){
    self.category = category
    refresh()
  }
  
  private func refresh() {
    DispatchQueue.main.async {
      [weak self] in
      self?.collectionView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView.register(UINib(nibName: "CharacterPortraitCell", bundle: nil), forCellWithReuseIdentifier: "CharacterPortraitID")
  }
  
  // MARK: UICollectionViewDataSource
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func indexTitles(for collectionView: UICollectionView) -> [String]? {
    return [self.category!.category]
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.category?.charactersCount ?? 0
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterPortraitID", for: indexPath) as! CharacterPortraitCell
    if let character = self.category?.getCharacter(at: indexPath.row) {
      let image = UIImage(named: character.imagePath)
      cell.characterImage.image = image?.roundedImage
      cell.characterNameLabel.text = character.name
      cell.characterAlterEgoLabel.text = character.alterEgo
    }
    return cell
  }
  
  // MARK: UICollectionViewDelegate
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if let category = self.category, let character = category.getCharacter(at: indexPath.row) {
      self.delegate?.onTappedCharacter(character: character)
      self.dismiss(animated: false, completion: nil)
    }
  }
  
}
