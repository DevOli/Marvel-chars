//
//  HomeViewModel.swift
//  MarvelCharsApp
//
//  Created by admin on 11/23/21.
//

import Foundation

protocol HomeViewModelDelegate {
  func onFetchDataSuccessfully(categories: [CategoryModel])
  func onFetchHeroes(heroes: CategoryModel)
}

class HomeViewModel {
  
  let manager = MarvelAPI()
  var delegate: HomeViewModelDelegate?
  var categories: [CategoryModel] = []
  var categoriesNames: [String] = []
  var heroes: [CharacterModel] = []
  var villains: [CharacterModel] = []
  var antiHeroes: [CharacterModel] = []
  var aliens: [CharacterModel] = []
  var humans: [CharacterModel] = []
  
  init(){
    self.manager.delegate = self
  }
  
  func fetchData() {
    self.manager.fetchData()
  }
  
  func setDelegate(delegate: HomeViewModelDelegate){
    self.delegate = delegate
  }
  
  func getCategoryWith(name: String) -> CategoryModel? {
    return self.categories.first(where: {(category) in category.category == name})
  }
  
}

extension HomeViewModel: MarvelAPIDelegate {
  
  func didFetchData(categories: [CategoryModel]) {
    self.heroes = categories[0].characters
    self.villains = categories[1].characters
    self.antiHeroes = categories[2].characters
    self.aliens = categories[3].characters
    self.humans = categories[4].characters
    self.categories = categories
    self.categoriesNames = self.categories.map{ category in category.category}
    self.delegate?.onFetchDataSuccessfully(categories: categories)
  }
  
}
