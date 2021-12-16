//
//  MenuListController.swift
//  MarvelCharsApp
//
//  Created by User on 30/11/21.
//

import Foundation
import SideMenu
import UIKit

class SideMenuController: UITableViewController {
    var sideMenuViewModel = SideMenuViewModel()
    weak var delegate: CharacterPortraitDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuViewModel.delegate = self
        sideMenuViewModel.fetchData()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
      self.tableView.backgroundColor = UIColor.primarySilver
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuViewModel.countCategories()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = sideMenuViewModel.getCategory(atIndex: indexPath.row).category
        cell.textLabel?.font = UIFont.profileSubtitle()
      cell.backgroundColor = UIColor.primarySilver
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
      self.dismiss(animated: true, completion: nil)
      self.delegate?.showCategoryView(category: sideMenuViewModel.getCategory(atIndex: indexPath.row))
    }
}

extension SideMenuController: SideMenuViewModelDelegate {
    func didFetchSuccessfuly(categories: [CategoryModel]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func didFailFetching(error: Error) {
        print(error)
    }
}
