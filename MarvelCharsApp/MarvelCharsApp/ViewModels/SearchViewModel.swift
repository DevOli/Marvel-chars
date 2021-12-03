//
//  SearchViewModel.swift
//  MarvelCharsApp
//
//  Created by User on 11/25/21.
//

import Foundation
class SearchViewModel {
    private var repository: MarvelRepository
    var refreshData = { () -> () in }
    var errorHandler = { (error: Error) -> () in }
    private var allCharacters: [CharacterModel] = []
    private var searchedItems: [CharacterModel] = [] {
        didSet {
            refreshData()
        }
    }
    
    init() {
        repository = MarvelAPI()
        repository.setDelegate(delegate: self)
    }
    
    init(repository: MarvelRepository) {
        self.repository = repository
        repository.setDelegate(delegate: self)
    }
    
    func count() -> Int {
        return searchedItems.count
    }
    
    func get(byIndex index: Int) -> CharacterModel {
        return searchedItems[index]
    }
    
    func getAllcharacters() {
        repository.fetchData()
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
        errorHandler(error)
    }
    
    func didFetchData(categories: [CategoryModel]) {
        categories.forEach { category in
            allCharacters += category.characters
        }
        searchedItems = allCharacters
    }
}
