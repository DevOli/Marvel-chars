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
  var viewModel: HomeViewModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    menu = SideMenuNavigationController(rootViewController: SideMenuController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: true)
        
        navigationItem.titleView = marvelLogo
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.register(UINib(nibName: "CategoryRowCell", bundle: nil), forCellReuseIdentifier: "CategoryRowID")
    // Do any additional setup after loading the view.
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
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "HomeToDetailsSegueID", let destination = segue.destination as? DetailsViewController, let character = sender as? CharacterModel {
      destination.character = character
    }
    
  }
  
  
}
    
    var menu: SideMenuNavigationController?
    // Quick Example to see if it works. Not final
    let marvelLogo = UIImageView(image: UIImage(named: "marvel")?.tintedWithLinearGradientColors(colorsArr: [UIColor(named: "gradient-red-b")!.cgColor, UIColor(named: "gradient-red-a")!.cgColor]))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        menu = SideMenuNavigationController(rootViewController: SideMenuController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: true)
        
        navigationItem.titleView = marvelLogo
    }
    
    @IBAction func didTapMenu() {
        present(menu!, animated: true)
    }
}
