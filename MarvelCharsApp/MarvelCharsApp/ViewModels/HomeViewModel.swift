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
  var heroes: [CharacterModel] = []
  
  init(){
    self.manager.delegate = self
  }
  
  func fetchData() {
    self.manager.fetchData()
  }
  
  func setDelegate(delegate: HomeViewModelDelegate){
    self.delegate = delegate
  }
  
}

extension HomeViewModel: MarvelAPIDelegate {
  
  func didFetchData(heroes: CategoryModel, villains: CategoryModel, antiHeroes: CategoryModel, aliens: CategoryModel, humans: CategoryModel) {
    self.heroes = heroes.characters
    self.heroes.append(contentsOf: heroes.characters)
    self.delegate?.onFetchHeroes(heroes: heroes)
  }
  
}
