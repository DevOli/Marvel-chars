//
//  CharactersCollectionViewController.swift
//  MarvelCharsApp
//
//  Created by admin on 12/1/21.
//

import UIKit

class CharactersCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  weak var delegate: CharacterPortraitDelegate?
  var category: CategoryModel?

  private let collectionViewCellNibName = "CharacterPortraitCell"
  private let cellReuseIdentifier = "CharacterPortraitID"
  private let collectionViewHeaderNibName = "CharactersCollectionHeader"
  private let headerReuseIdentifier = "CharacterCollectionReusableViewID"

  func configure(category: CategoryModel?) {
    self.category = category
    refresh()
  }

  private func refresh() {
    DispatchQueue.main.async { [weak self] in
      self?.collectionView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView.register(UINib(nibName: self.collectionViewCellNibName, bundle: nil),
                                 forCellWithReuseIdentifier: self.cellReuseIdentifier)
    self.collectionView.register(UINib(nibName: self.collectionViewHeaderNibName, bundle: nil),
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                 withReuseIdentifier: self.headerReuseIdentifier)
    configureNavBar()
  }

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.category?.charactersCount ?? 0
  }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: self.cellReuseIdentifier,
                                                             for: indexPath) as? CharacterPortraitCell else {
      return UICollectionViewCell()
    }
    if let character = self.category?.getCharacter(at: indexPath.row) {
      let image = UIImage(named: character.imagePath)
      cell.dropShadow(color: image?.averageColor ?? .clear)
      cell.characterImage.image = image?.roundedImage
      cell.characterNameLabel.text = character.name
      cell.characterAlterEgoLabel.text = character.alterEgo
    }
    return cell
  }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if let category = self.category, let character = category.getCharacter(at: indexPath.row) {
      self.delegate?.onTappedCharacter(character: character)
      self.dismiss(animated: false, completion: nil)
    }
  }
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
    if (kind == UICollectionView.elementKindSectionHeader),
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind:
                                            UICollectionView.elementKindSectionHeader,
                                            withReuseIdentifier: self.headerReuseIdentifier,
                                            for: indexPath) as? CharactersCollectionHeader {
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
    let barTintColor = navigationController?.navigationBar.barTintColor
    let backgroundColor = navigationController?.navigationBar.backgroundColor
    self.navigationController?.navigationBar.isTranslucent = true
    let action = UIAction { _ in
      self.navigationController?.navigationBar.barTintColor = barTintColor
      self.navigationController?.navigationBar.backgroundColor = backgroundColor
      self.navigationController?.popViewController(animated: true)
    }
    let button = UIBarButtonItem(title: "", image: UIImage(named: "back"), primaryAction: action, menu: nil)
    button.tintColor = UIColor.primary_white
    navigationItem.leftBarButtonItem = button

    self.title = self.category?.category
    navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.primary_white]
    navigationController?.navigationBar.backgroundColor = UIColor.primary_red

  }

  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    let TopHeight = navigationController?.navigationBar.frame.maxY ?? 0

    if (scrollView.contentOffset.y <= -TopHeight){
      navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.primary_white]
      navigationItem.leftBarButtonItem?.tintColor = .primary_white
    }

    if (scrollView.contentOffset.y > -TopHeight && scrollView.contentOffset.y < (scrollView.contentSize.height - scrollView.frame.size.height)){
      navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.primary_red]
      navigationItem.leftBarButtonItem?.tintColor = .primary_red
    }
  }
}
