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
  // Quick Example to see if it works. Not final
  let marvelLogo = UIImageView(image: UIImage(named: "marvel")?.tintedWithLinearGradientColors(colorsArr: [UIColor(named: "gradient-red-b")!.cgColor, UIColor(named: "gradient-red-a")!.cgColor]))
  
  @IBOutlet weak var tableView: UITableView!
  
  private let cellReuseIdentifier = "CategoryRowID"
  private let tableViewCellNibName = "CategoryRowCell"
  private let homeToDetailsSegueIdentifier = "HomeToDetailsSegueID"
  
  var viewModel: HomeViewModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    menu = SideMenuNavigationController(rootViewController: SideMenuController())
    menu?.leftSide = true
    menu?.setNavigationBarHidden(true, animated: true)
    
    navigationItem.titleView = marvelLogo
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.register(UINib(nibName: self.tableViewCellNibName, bundle: nil), forCellReuseIdentifier: self.cellReuseIdentifier)
    viewModel = HomeViewModel()
    viewModel?.setDelegate(delegate: self)
    viewModel?.fetchData()
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

extension HomeViewController: CategoryRowCellDelegate {
  func onTappedCharacter(character: CharacterModel) {
    self.performSegue(withIdentifier: self.homeToDetailsSegueIdentifier, sender: character)
  }
  
  func showCategoryView(category: CategoryModel) {
    let vc = CharactersCollectionViewController(nibName: "CharactersCollectionViewController", bundle: nil)
    vc.configure(category: category)
    vc.delegate = self
    self.present(vc, animated: true, completion: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == self.homeToDetailsSegueIdentifier, let destination = segue.destination as? DetailsViewController, let character = sender as? CharacterModel {
      destination.character = character
    }
    
  }
  
  
}
