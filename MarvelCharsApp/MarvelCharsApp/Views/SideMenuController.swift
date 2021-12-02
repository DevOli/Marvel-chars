//
//  MenuListController.swift
//  MarvelCharsApp
//
//  Created by User on 30/11/21.
//

import Foundation
import SideMenu

class SideMenuController: UITableViewController {

    var sideMenuViewModel = SideMenuViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuViewModel.delegate = self
        sideMenuViewModel.fetchData()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuViewModel.countCategories()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = sideMenuViewModel.getCategory(at: indexPath.row).category
        cell.textLabel?.font = UIFont(name: "gilroy-medium", size: 16)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
