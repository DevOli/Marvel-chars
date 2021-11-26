//
//  ViewController.swift
//  MarvelCharsApp
//
//  Created by admin on 11/23/21.
//

import UIKit

class HomeViewController: UIViewController {
  
  
  
  @IBOutlet weak var heroesCollectionView: UICollectionView!
  var viewModel: HomeViewModel?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    heroesCollectionView.dataSource = self
    heroesCollectionView.delegate = self
    heroesCollectionView.register(UINib(nibName: "CharacterPortraitCell", bundle: nil), forCellWithReuseIdentifier: "CharacterPortrait")
    // Do any additional setup after loading the view.
    viewModel = HomeViewModel()
    viewModel?.setDelegate(delegate: self)
    viewModel?.fetchData()
  }
  
  private func refresh() {
    DispatchQueue.main.async {
      [weak self] in
      self?.heroesCollectionView.reloadData()
    }
  }
  
}

extension HomeViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if let count = viewModel?.heroes.count {
      return count
    }
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = heroesCollectionView.dequeueReusableCell(withReuseIdentifier: "CharacterPortrait", for: indexPath) as! CharacterPortraitCell
    if let hero = viewModel?.heroes[indexPath.row] {
      let image = UIImage(named: hero.imagePath)
      cell.characterImage.image = image?.roundedImage
      cell.characterNameLabel.text = hero.name
      cell.characterAlterEgoLabel.text = hero.alterEgo
    }
    return cell
  }
  
}

extension HomeViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewControllerID") as! DetailsViewController
    self.present(vc, animated: true, completion: nil)
  }
}

extension HomeViewController: HomeViewModelDelegate {
  func onFetchDataSuccessfully(categories: [CategoryModel]) {
    return
  }
  
  func onFetchHeroes(heroes: CategoryModel) {
    refresh()
  }
  
}

