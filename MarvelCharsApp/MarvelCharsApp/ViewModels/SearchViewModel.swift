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
            searchedItems = searchedItems.filter { (character: CharacterModel) -> Bool in
                return (character.name.lowercased().contains(name.lowercased()))
            }
        } else {
            apiCaller.fetchData()
        }
    }
    
}

extension SearchViewModel: MarvelAPIDelegate {
    func didFetchData(categories: [CategoryModel]) {
        var charnames: [CharacterModel] = []
        categories.forEach { category in
            charnames += category.characters
        }
        searchedItems = charnames
    }
}
