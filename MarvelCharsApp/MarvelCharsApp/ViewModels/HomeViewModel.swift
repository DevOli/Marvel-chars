//
//  HomeViewModel.swift
//  MarvelCharsApp
//
//  Created by admin on 11/23/21.
//

import Foundation

protocol HomeViewModelDelegate {
  func onFetchDataSuccessfully(categories: [CategoryModel])
  
}

class HomeViewModel {
  
  let manager = MarvelAPI()
  var delegate: HomeViewModelDelegate?
  var categories: [CategoryModel] = []
  var categoriesNames: [String] = []
  
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
    self.categories = categories
    self.categoriesNames = self.categories.map{ category in category.category}
    self.delegate?.onFetchDataSuccessfully(categories: categories)
  }
  
}
