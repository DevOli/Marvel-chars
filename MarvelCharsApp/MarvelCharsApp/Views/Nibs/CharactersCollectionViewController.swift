//
//  CharactersCollectionViewController.swift
//  MarvelCharsApp
//
//  Created by admin on 12/1/21.
//

import UIKit

class CharactersCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  var delegate: CharacterPortraitDelegate?
  var category: CategoryModel?
  let loader = ImageLoader()
  
  private let collectionViewCellNibName = "CharacterPortraitCell"
  private let cellReuseIdentifier = "CharacterPortraitID"
  private let collectionViewHeaderNibName = "CharactersCollectionHeader"
  private let headerReuseIdentifier = "CharacterCollectionReusableViewID"
  
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
    self.collectionView.register(UINib(nibName: self.collectionViewCellNibName, bundle: nil), forCellWithReuseIdentifier: self.cellReuseIdentifier)
    self.collectionView.register(UINib(nibName: self.collectionViewHeaderNibName, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerReuseIdentifier)
    configureNavBar()
  }
  
  // MARK: UICollectionViewDataSource
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.category?.charactersCount ?? 0
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: self.cellReuseIdentifier, for: indexPath) as? CharacterPortraitCell else {
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
            //cell.dropShadow(color: image.averageColor ?? .clear)
            cell.characterImage.image = image.roundedImage
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
  
  // MARK: UICollectionViewDelegate
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if let category = self.category, let character = category.getCharacter(at: indexPath.row) {
      self.delegate?.onTappedCharacter(character: character)
      self.dismiss(animated: false, completion: nil)
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if (kind == UICollectionView.elementKindSectionHeader), let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerReuseIdentifier, for: indexPath) as? CharactersCollectionHeader{
      headerView.categoryTitleLabel.text = self.category?.category
      return headerView
    }
    return UICollectionReusableView()
  }
  
  // MARK: UICollectionViewDelegateFlowLayout
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
      layout.sectionHeadersPinToVisibleBounds = true
    }
    return CGSize(width: 150.0, height: 260.0)
  }
  
  func configureNavBar() {
    self.navigationController?.navigationBar.isTranslucent = true
    let action = UIAction { UIAction in
      self.navigationController?.popViewController(animated: true)
    }
    let button = UIBarButtonItem(title: "", image: UIImage(named: "back"), primaryAction: action, menu: nil)
    button.tintColor = UIColor.primary_dark
    navigationItem.leftBarButtonItem = button
  }
  
}
