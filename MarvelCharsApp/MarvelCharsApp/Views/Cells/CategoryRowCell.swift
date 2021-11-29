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
  var characters: [CharacterModel]?
  
  func configure(characters: [CharacterModel]?){
    self.characters = characters
    refresh()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    charactersCollectionView.register(UINib(nibName: "CharacterPortraitCell", bundle: nil), forCellWithReuseIdentifier: "CharacterPortraitID")
    charactersCollectionView.dataSource = self
    charactersCollectionView.delegate = self
    
    // Do any additional setup after loading the view.
    //viewModel = HomeViewModel()
    //viewModel?.setDelegate(delegate: self)
    //viewModel?.fetchData()
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
    /*if let count = characters?.count {
      return count
    }*/
    return 6
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = charactersCollectionView.dequeueReusableCell(withReuseIdentifier: "CharacterPortraitID", for: indexPath) as! CharacterPortraitCell
    /*if let hero = characters?[indexPath.row] {
      let image = UIImage(named: hero.imagePath)
      cell.characterImage.image = image?.roundedImage
      cell.characterNameLabel.text = hero.name
      cell.characterAlterEgoLabel.text = hero.alterEgo
    }*/
    let image = UIImage(named: "spider-man")
    cell.characterImage.image = image?.roundedImage
    //let cell = UICollectionViewCell()
    return cell
  }
  
}

extension CategoryRowCell: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    return
  }
}

extension CategoryRowCell: HomeViewModelDelegate {
  func onFetchDataSuccessfully(categories: [CategoryModel]) {
    return
  }
  
  func onFetchHeroes(heroes: CategoryModel) {
    refresh()
  }
  
}
