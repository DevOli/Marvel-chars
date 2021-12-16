//
//  MarvelRepository.swift
//  MarvelCharsApp
//
//  Created by User on 30/11/21.
//

import Foundation
protocol MarvelRepository {
    func fetchData()
    func fetchMovie(byKey: String)
    func setDelegate(delegate: MarvelRepositoryDelegate)
    func setDelegate(forMovie: MarvelMoviesDelegate)
}
protocol MarvelRepositoryDelegate {
    func didFetchData(categories: [CategoryModel])
    func didFailFetching(error: Error)
}

protocol MarvelMoviesDelegate {
    func didFetchMovies(movie: MovieModel)
    func didFailFetching(error: Error)
}


