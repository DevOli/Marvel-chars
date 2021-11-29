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
  var categoryIndex = 0
  
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
    if let count = viewModel?.categories.count {
      self.categoryIndex = 0
      return count
    }
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCell(withIdentifier: "CategoryRowID", for: indexPath) as! CategoryRowCell
    cell.configure(category: cell.category ?? viewModel?.categoriesNames[categoryIndex] ?? "")
    cell.viewModel = self.viewModel
    self.categoryIndex += 1
    return cell
  }
  
}

extension HomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewControllerID") as! DetailsViewController
    self.present(vc, animated: true, completion: nil)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 310.0
  }
}

extension HomeViewController: HomeViewModelDelegate {
  func onFetchDataSuccessfully(categories: [CategoryModel]) {
    refresh()
    return
  }
  
  func onFetchHeroes(heroes: CategoryModel) {
    refresh()
  }
  
}

