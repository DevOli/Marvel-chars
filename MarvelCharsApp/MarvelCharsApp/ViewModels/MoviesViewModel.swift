//
//  MoviesViewModel.swift
//  MarvelCharsApp
//
//  Created by User on 12/13/21.
//

import Foundation
class MoviesViewModel {
    private var repository: MarvelRepository
    var refreshData: () -> ()
    var errorHandler: (Error) -> ()

    private var movie: MovieModel? {
        didSet {
            refreshData()
        }
    }
    
    init() {
        refreshData = { () -> () in }
        errorHandler = { (error: Error) -> () in }
        repository = MarvelAPI()
        repository.setDelegate(delegate: self)
    }
    
    init(repository: MarvelRepository, refreshData: @escaping () -> (), errorHandler: @escaping (Error) -> ()) {
        self.refreshData = refreshData
        self.errorHandler = errorHandler
        
        self.repository = repository
        self.repository.setDelegate(delegate: self)
    }
    
    func getMovie(byName name:String) {        
        repository.fetchMovie(byName: name)
    }
    
    func getMovieImage() -> String {
        return movie?.image ?? ""
    }
}

extension MoviesViewModel: MarvelRepositoryDelegate {
    func didFetchMovies(movie: MovieModel) {
        self.movie = movie
    }
    
    func didFailFetching(error: Error) {
        errorHandler(error)
    }
    
    func didFetchData(categories: [CategoryModel]) {

    }
}
