//
//  SearchTableViewController.swift
//  MarvelCharsApp
//
//  Created by User on 11/25/21.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    let searchVm = SearchViewModel()
    let searchController = UISearchController(searchResultsController: nil)
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfiguration()
    }
    
    private func initialConfiguration() {
      //Search UI configurations
      searchController.searchResultsUpdater = self
      searchController.obscuresBackgroundDuringPresentation = false
      searchController.searchBar.placeholder = "Search Characters"
      tableView.tableHeaderView = searchController.searchBar
      definesPresentationContext = true
      // Search VM configurations
      searchVm.getAllcharacters()
      assignClosureToViewModel()
    }
  
    private func assignClosureToViewModel() {
      searchVm.refreshData = {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
      }
    }

    // MARK: - Table view data sourc

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchVm.count()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
        let character = searchVm.get(byIndex: indexPath.row)
        cell.textLabel?.text = character.name
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
          searchVm.getCharacters(byName: searchText)
        }
    }
}
