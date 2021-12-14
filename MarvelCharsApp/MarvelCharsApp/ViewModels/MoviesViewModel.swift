//
//  MoviesViewModel.swift
//  MarvelCharsApp
//
//  Created by User on 12/13/21.
//

import Foundation
class MoviesViewModel {
    private var repository: MarvelRepository
    var refreshData: (MovieModel) -> Void
    var errorHandler: (Error) -> Void
    var movie: MovieModel?
    
    init() {
        refreshData = { (MovieModel) -> () in }
        errorHandler = { (error: Error) -> () in }
        repository = MarvelAPI()
        repository.setDelegate(delegate: self)
    }
    
    init(repository: MarvelRepository, refreshData: @escaping (MovieModel) -> Void, errorHandler: @escaping (Error) ->Void) {
        self.refreshData = refreshData
        self.errorHandler = errorHandler
        
        self.repository = repository
        self.repository.setDelegate(delegate: self)
    }
    
    func getMovie(byKey key:String) {
        repository.fetchMovie(byKey: key)
    }
    
    func getMovieImage() -> String {
        return movie?.image ?? ""
    }
    
    func getMovieTitle() -> String {
        return movie?.name ?? ""
    }
    
    func getMovieSynop() -> String {
        return movie?.synopsis ?? ""
    }
    
    func getMovieUrl() -> String {
        return movie?.trailer ?? ""
    }
}

extension MoviesViewModel: MarvelRepositoryDelegate {
    func didFetchMovies(movie: MovieModel) {
        self.movie = movie
        refreshData(movie)
    }
    
    func didFailFetching(error: Error) {
        errorHandler(error)
    }
    
    func didFetchData(categories: [CategoryModel]) {

    }
}
