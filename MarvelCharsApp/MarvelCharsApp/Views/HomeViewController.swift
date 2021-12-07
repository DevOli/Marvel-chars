//
//  ViewController.swift
//  MarvelCharsApp
//
//  Created by admin on 11/23/21.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController {
  
  var menu: SideMenuNavigationController?
  let marvelLogo = UIImageView(image: UIImage(named: "marvel")?.tintedWithLinearGradientColors(colorsArr: [UIColor(named: "gradient-red-b")!.cgColor, UIColor(named: "gradient-red-a")!.cgColor]))
  var categoryButton: [(categoryName: String, colours: [UIColor])] = [
      (categoryName: "hero", colours: [.gradient_blue_a, .gradient_blue_b]),
      (categoryName: "villain", colours: [.gradient_red_a, .gradient_red_b]),
      (categoryName: "antihero", colours: [.gradient_purple_a, .gradient_purple_b]),
      (categoryName: "alien", colours: [.gradient_green_a, .gradient_green_b]),
      (categoryName: "human", colours: [.gradient_pink_a, .gradient_pink_b])
  ]
    
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var welcomeLabel: UILabel!
  @IBOutlet weak var mainTitleLabel: UILabel!

  private let cellReuseIdentifier = ResourceName.cellReuseIdentifier
  private let tableViewCellNibName = ResourceName.tableViewCellNibName
  private let homeToDetailsSegueIdentifier = ResourceName.homeToDetailsSegueIdentifier
  private let charactersCollectionVCNibName = ResourceName.charactersCollectionVCNibName
  
  var viewModel: HomeViewModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let menuController = SideMenuController()
    menuController.delegate = self
    menu = SideMenuNavigationController(rootViewController: menuController)
    menu?.leftSide = true
    menu?.setNavigationBarHidden(true, animated: true)
    
    navigationItem.titleView = marvelLogo

    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.register(UINib(nibName: self.tableViewCellNibName, bundle: nil), forCellReuseIdentifier: self.cellReuseIdentifier)
    viewModel = HomeViewModel()
    viewModel?.setDelegate(delegate: self)
    viewModel?.fetchData()
      
    welcomeLabel.text = "Welcome to Marvel Heroes"
    welcomeLabel.font = UIFont.homeSubtitle()
    welcomeLabel.textColor = UIColor.primary_grey
      
    mainTitleLabel.text = "Choose a character"
    mainTitleLabel.font = UIFont.homeTitle()
    mainTitleLabel.textColor = UIColor.primary_dark
      
  }
  
  @IBAction func didTapMenu() {
    present(menu!, animated: true)
  }
  
  private func refresh() {
    DispatchQueue.main.async {
      [weak self] in
      self?.tableView.reloadData()
    }
  }
    
  func scrollToCategory(category: Int) {
    let sectionIndexPath = IndexPath(row: category, section: 0)
    self.tableView.scrollToRow(at: sectionIndexPath, at: .top, animated: true)
  }
  
}

extension HomeViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel?.categories.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = self.tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath) as? CategoryRowCell else {
      return UITableViewCell()
    }
    cell.configure(category: viewModel?.categories[indexPath.row])
    cell.delegate = self
    return cell
  }
  
}

extension HomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 310.0
  }
}

extension HomeViewController: HomeViewModelDelegate {
  func onFetchDataSuccessfully(categories: [CategoryModel]) {
    refresh()
  }
  
}

extension HomeViewController: CharacterPortraitDelegate {
  func onTappedCharacter(character: CharacterModel) {
    self.performSegue(withIdentifier: self.homeToDetailsSegueIdentifier, sender: character)
  }
  
  func showCategoryView(category: CategoryModel) {
    let vc = CharactersCollectionViewController(nibName: self.charactersCollectionVCNibName, bundle: nil)
    vc.configure(category: category)
    vc.delegate = self
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == self.homeToDetailsSegueIdentifier, let destination = segue.destination as? DetailsViewController, let character = sender as? CharacterModel {
      destination.character = character
    }
    
  }
    
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryButton.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryButtonCollectionViewCell", for: indexPath) as! CategoryButtonCollectionViewCell
        
        cell.categoryButton.setImage(UIImage(named: categoryButton[indexPath.row].categoryName), for: .normal)
        cell.categoryButton.buttonTitleStyles(colours: categoryButton[indexPath.row].colours)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        scrollToCategory(category: indexPath.row)
    }
}
