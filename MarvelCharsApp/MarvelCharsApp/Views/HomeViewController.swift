//
//  ViewController.swift
//  MarvelCharsApp
//
//  Created by admin on 11/23/21.
//

import SideMenu
import UIKit

class HomeViewController: UIViewController {
  var menu: SideMenuNavigationController?
    let marvelLogo = UIImageView(image: UIImage(named: "marvel")?.tintedWithLinearGradientColors(colorsArr:
                                                [UIColor(named: "gradient-red-b")!.cgColor,
                                                 UIColor(named: "gradient-red-a")!.cgColor]))
  var categoryButton: [(categoryName: String, colours: [UIColor])] = [
      (categoryName: "hero", colours: [.gradientBlueA, .gradientBlueB]),
      (categoryName: "villain", colours: [.gradientRedA, .gradientRedB]),
      (categoryName: "antihero", colours: [.gradientPurpleA, .gradientPurpleB]),
      (categoryName: "alien", colours: [.gradientGreenA, .gradientGreenB]),
      (categoryName: "human", colours: [.gradientPinkA, .gradientPinkB])
  ]

  @IBOutlet var tableView: UITableView!
  @IBOutlet var welcomeLabel: UILabel!
  @IBOutlet var mainTitleLabel: UILabel!

  private let cellReuseIdentifier = ResourceName.cellReuseIdentifier
  private let tableViewCellNibName = ResourceName.tableViewCellNibName
  private let homeToDetailsSegueIdentifier = ResourceName.homeToDetailsSegueIdentifier
  private let charactersCollectionVCNibName = ResourceName.charactersCollectionVCNibName
  private let categoryButtonCollectionViewCell = ResourceName.categoryButtonCollectionViewCell

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
    self.tableView.register(UINib(nibName: self.tableViewCellNibName, bundle: nil),
                            forCellReuseIdentifier: self.cellReuseIdentifier)
    viewModel = HomeViewModel()
    viewModel?.setDelegate(delegate: self)
    viewModel?.fetchData()

    welcomeLabel.text = "Welcome to Marvel Heroes"
    welcomeLabel.font = UIFont.homeSubtitle()
    welcomeLabel.textColor = UIColor.primaryGrey

    mainTitleLabel.text = "Choose a character"
    mainTitleLabel.font = UIFont.homeTitle()
    mainTitleLabel.textColor = UIColor.primaryDark
  }

  @IBAction func didTapMenu() {
    present(menu!, animated: true)
  }

  private func refresh() {
    DispatchQueue.main.async { [weak self] in
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
    guard let cell = self.tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier,
                                                        for: indexPath) as? CategoryRowCell else {
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
  func onFetchDataFail() {
      let alertController = UIAlertController(title: "Error",
                                              message: "We are unable to get character information.",
                                              preferredStyle: .alert)
      let okAction = UIAlertAction(title: "Ok", style: .default)
      alertController.addAction(okAction)
      self.present(alertController, animated: true, completion: nil)
  }

  func onFetchDataSuccessfully(categories: [CategoryModel]) {
    refresh()
  }
}

extension HomeViewController: CharacterPortraitDelegate {
  func onTappedCharacter(character: CharacterModel) {
    self.performSegue(withIdentifier: self.homeToDetailsSegueIdentifier, sender: character)
  }

  func showCategoryView(category: CategoryModel) {
    let viewC = CharactersCollectionViewController(nibName: self.charactersCollectionVCNibName, bundle: nil)
    viewC.configure(category: category)
    viewC.delegate = self
    self.navigationController?.pushViewController(viewC, animated: true)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == self.homeToDetailsSegueIdentifier,
                            let destination = segue.destination as? DetailsViewController,
                            let character = sender as? CharacterModel {
      destination.character = character
    }
  }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryButton.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.categoryButtonCollectionViewCell,
                                                            for: indexPath) as? CategoryButtonCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.categoryButton.setImage(UIImage(named: categoryButton[indexPath.row].categoryName), for: .normal)
        cell.categoryButton.buttonTitleStyles(colours: categoryButton[indexPath.row].colours)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        scrollToCategory(category: indexPath.row)
    }
}
