//
//  MarvelRepository.swift
//  MarvelCharsApp
//
//  Created by User on 30/11/21.
//

import Foundation
protocol MarvelRepository {
    func fetchData()
    func fetchMovieData()
    func setDelegate(delegate: MarvelRepositoryDelegate)
}
protocol MarvelRepositoryDelegate {
    func didFetchData(categories: [CategoryModel])
    func didFetchMovies(movies: [MovieModel])
    func didFailFetching(error: Error)
}


