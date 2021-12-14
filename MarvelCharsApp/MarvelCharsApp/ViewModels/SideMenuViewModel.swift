//
//  CategoriesViewModel.swift
//  MarvelCharsApp
//
//  Created by User on 29/11/21.
//

import Foundation

protocol SideMenuViewModelDelegate: AnyObject {
    func didFetchSuccessfuly(categories: [CategoryModel])
    func didFailFetching(error: Error)
}

class SideMenuViewModel {
    var categoriesList: [CategoryModel] = []
    weak var delegate: SideMenuViewModelDelegate?
    var repository: MarvelRepository

    init() {
        repository = MarvelAPI()
        repository.setDelegate(delegate: self)
    }

    init(repository: MarvelRepository) {
        self.repository = repository
        repository.setDelegate(delegate: self)
    }

    func countCategories() -> Int {
        return categoriesList.count
    }

    func getCategory( atIndex: Int) -> CategoryModel {
        return categoriesList[atIndex]
    }

    func fetchData() {
        repository.fetchData()
    }
}

extension SideMenuViewModel: MarvelRepositoryDelegate {
    func didFetchData(categories: [CategoryModel]) {
        categoriesList = categories
        delegate?.didFetchSuccessfuly(categories: categories)
    }

    func didFailFetching(error: Error) {
        delegate?.didFailFetching(error: error)
    }
}
