//
//  ViewController.swift
//  MarvelCharsApp
//
//  Created by admin on 11/23/21.
//

import UIKit

class HomeViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  var viewModel: HomeViewModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.register(UINib(nibName: "CategoryRowCell", bundle: nil), forCellReuseIdentifier: "CategoryRowID")
    // Do any additional setup after loading the view.
    viewModel = HomeViewModel()
    viewModel?.setDelegate(delegate: self)
    viewModel?.fetchData()
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
    let cell = self.tableView.dequeueReusableCell(withIdentifier: "CategoryRowID", for: indexPath) as! CategoryRowCell
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
    return
  }
  
}

extension HomeViewController: CategoryRowCellDelegate {
  func onTappedCharacter(character: CharacterModel) {
    self.performSegue(withIdentifier: "HomeToDetailsSegueID", sender: character)
  }
  
  func showCategoryView(category: CategoryModel) {
    let vc = CharactersCollectionViewController(nibName: "CharactersCollectionViewController", bundle: nil)
    vc.configure(category: category)
    vc.delegate = self
    self.present(vc, animated: true, completion: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "HomeToDetailsSegueID", let destination = segue.destination as? DetailsViewController, let character = sender as? CharacterModel {
      destination.character = character
    }
    
  }
  
  
}
