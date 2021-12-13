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

    private var movies: [MovieModel] = []
    
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
    
    func getAllMovies() {
        repository.fetchMovieData()
    }
    
    func getMovie(byName name:String) {
        if let safeMovie = self.movies.first(where: {(movie) in movie.name == name}) {
            movie = safeMovie
        }
    }
}

extension MoviesViewModel: MarvelRepositoryDelegate {
    func didFetchMovies(movies: [MovieModel]) {
        print(movies)
    }
    
    func didFailFetching(error: Error) {
        errorHandler(error)
    }
    
    func didFetchData(categories: [CategoryModel]) {

    }
}
