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
  
  func count() -> Int {
    return searchedItems.count
  }
  
  func getAllcharacters() {
    apiCaller.fetchData()
  }
  
  func get(index: Int) -> CharacterModel {
    return searchedItems[index]
  }
  
  func filter(byName name:String) {
    searchedItems = searchedItems.filter { (character: CharacterModel) -> Bool in
          return (character.name.lowercased().contains(name.lowercased()))
      }
  }
  
}

extension SearchViewModel: MarvelAPIDelegate {
  func didFetchData(heroes: CategoryModel, villains: CategoryModel, antiHeroes: CategoryModel, aliens: CategoryModel, humans: CategoryModel) {
    searchedItems = heroes.characters + villains.characters + antiHeroes.characters + aliens.characters + humans.characters
  }
}
