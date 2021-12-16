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
        refreshData = { _ -> Void in }
        errorHandler = { (_: Error) -> Void in }
        repository = MarvelAPI()
        repository.setDelegate(forMovie: self)
    }

    init(repository: MarvelRepository, refreshData: @escaping (MovieModel) -> Void,
         errorHandler: @escaping (Error) -> Void) {
        self.refreshData = refreshData
        self.errorHandler = errorHandler
        self.repository = repository
        self.repository.setDelegate(forMovie: self)
    }

    func getMovie(byKey key: String) {
        repository.fetchMovie(byKey: key)
    }
}

extension MoviesViewModel: MarvelMoviesDelegate {
    func didFetchMovies(movie: MovieModel) {
        var embedMovie = movie
        embedMovie.embedUrlTrailer()
        self.movie = embedMovie
        refreshData(embedMovie)
    }

    func didFailFetching(error: Error) {
        errorHandler(error)
    }
}
