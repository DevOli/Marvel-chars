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
      searchController.searchBar.backgroundColor = UIColor.primary_silver
      searchController.searchBar.barTintColor = UIColor.primary_silver
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by character"
        searchController.searchBar.delegate = self;
        searchController.searchBar.showsCancelButton = true
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesBackButton = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
        definesPresentationContext = true
        // Search VM configurations
        searchVm.getAllcharacters()
        assignClosureToViewModel()
        searchVm.refreshData = {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: ResourceName.searchNameCell, for: indexPath)
        let character = searchVm.get(byIndex: indexPath.row)
        cell.textLabel?.text = character.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: ResourceName.mainStoryBoardName, bundle: nil)
            .instantiateViewController(withIdentifier: ResourceName.detailsViewController) as? DetailsViewController {
            vc.character = searchVm.get(byIndex: indexPath.row)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

// MARK: - Search Results Update

extension SearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            searchVm.getCharacters(byName: searchText)
        }
    }
}

// MARK: - Search Delegate

extension SearchTableViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.text = ""
        // Go to home
        self.navigationController?.popViewController(animated: true)
    }
}
