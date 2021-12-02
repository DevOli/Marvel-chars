//
//  SearchViewModel.swift
//  MarvelCharsApp
//
//  Created by User on 11/25/21.
//

import Foundation
class SearchViewModel {
    private var apiCaller = MarvelAPI()
    var refreshData = { () -> () in }
    private var allCharacters: [CharacterModel] = []
    private var searchedItems: [CharacterModel] = [] {
        didSet {
            refreshData()
        }
    }
    
    init() {
        apiCaller.delegate = self
    }
    
    func count() -> Int {
        return searchedItems.count
    }
    
    func get(byIndex index: Int) -> CharacterModel {
        return searchedItems[index]
    }
    
    func getAllcharacters() {
        apiCaller.fetchData()
    }
    
    func getCharacters(byName name:String) {
        if !name.isEmpty {
            searchedItems = allCharacters.filter { (character: CharacterModel) -> Bool in
                return (character.name.lowercased().contains(name.lowercased()))
            }
        } else {
            searchedItems = allCharacters
        }
    }
    
}

extension SearchViewModel: MarvelRepositoryDelegate {
    func didFailFetching(error: Error) {
        print(error)
    }
    
    func didFetchData(categories: [CategoryModel]) {
        categories.forEach { category in
            allCharacters += category.characters
        }
        searchedItems = allCharacters
    }
}
