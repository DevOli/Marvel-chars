//
//  MockMarvelAPI.swift
//  MarvelCharsAppTests
//
//  Created by User on 12/14/21.
//

import Foundation
class MockMarvelAPI: MarvelRepository {
    
    var delegate: MarvelRepositoryDelegate?
    
    func setDelegate(delegate: MarvelRepositoryDelegate) {
        self.delegate = delegate
    }
    
    let characterOne = CharacterModel(name: "SpidermanTest", alterEgo: "AlterEgoTest", imagePath: "", biography: "", birth: "", weight: 0, weightUnit: "", height: 0, heightUnit: "", universe: "", force: 0, intelligence: 0, agility: 0, endurance: 0, velocity: 0, movies: [])
    let characterTwo = CharacterModel(name: "IronManTest", alterEgo: "AlterEgoTest", imagePath: "", biography: "", birth: "", weight: 0, weightUnit: "", height: 0, heightUnit: "", universe: "", force: 0, intelligence: 0, agility: 0, endurance: 0, velocity: 0, movies: [])
    let characterThree = CharacterModel(name: "DeadPoolTest", alterEgo: "AlterEgoTest", imagePath: "", biography: "", birth: "", weight: 0, weightUnit: "", height: 0, heightUnit: "", universe: "", force: 0, intelligence: 0, agility: 0, endurance: 0, velocity: 0, movies: [])
    
    let mockedMovieOne = MovieModel(name: "Iron Man", key: "iron-man-1", image: "iron-man-1", trailer: "https://www.youtube.com/watch?v=8ugaeA-nMTc", synopsis: "A billionaire industrialist ...")
    
    let mockedMovieTwo = MovieModel(name: "The Incredible Hulk", key: "hulk", image: "hulk", trailer: "https://www.youtube.com/watch?v=dz6eBeW19Lg", synopsis: "Scientist Bruce Banner ...")

    
    func fetchData() {
        let categories = [CategoryModel(category: "CategoryTest", characters: [characterOne, characterTwo, characterThree])]
        self.delegate?.didFetchData(categories: categories)
    }
    
    func fetchMovie(byKey: String) {
        let movies = [mockedMovieOne, mockedMovieTwo]

        if let mockedMovie = movies.filter({ $0.key == byKey }).first {
            self.delegate?.didFetchMovies(movie: mockedMovie)
        } else {
            let error = CustomError.testError(message: "Fetch Data failed")
            self.delegate?.didFailFetching(error: error)
        }
    }
    
}

enum CustomError: Error {
    case testError(message: String)
}
