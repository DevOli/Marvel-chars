//
//  MarvelAPI.swift
//  MarvelCharsApp
//
//  Created by admin on 11/24/21.
//

import Foundation

class MarvelAPI : MarvelRepository {
    
    func setDelegate(delegate: MarvelRepositoryDelegate) {
        self.delegate = delegate
    }
    
    private let baseURL = "https://619d463f131c600017088e71.mockapi.io/api/v1/"
    
    var delegate: MarvelRepositoryDelegate?

    func fetchData() {
        let urlString = baseURL + "characters"
        let url = URL(string: urlString)
        guard let urlSafe = url else {
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlSafe) {
            [weak self]
            (data: Data?, response: URLResponse?, error: Error?) in
            let decoder = JSONDecoder()
            guard let safeData = data else {
                return
            }
            let marvelAPI = try? decoder.decode(Category.self, from: safeData)
            guard let results = marvelAPI else {
                return
            }
            
            let categories: [CategoryModel] = results.map { CategoryElement in
                let chars = self?.getCharactersFrom(category: CategoryElement.characterList)
                return CategoryModel(category: CategoryElement.name, characters: chars ?? [])
            }
            self?.delegate?.didFetchData(categories: categories)
        }
        task.resume()
    }
    
    func fetchMovie(byKey key: String) {
        let urlString = baseURL + "movies"
        let url = URL(string: urlString)
        guard let urlSafe = url else {
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlSafe) {
            [weak self]
            (data: Data?, response: URLResponse?, error: Error?) in
            let decoder = JSONDecoder()
            guard let safeData = data else {
                return
            }
            let marvelAPI = try? decoder.decode(Movies.self, from: safeData)
            guard let results = marvelAPI else {
                return
            }
            
            let movies: [MovieModel] = results.map { movie in
                return MovieModel(name: movie.name ?? "",
                                  key: movie.key ?? "",
                                  image: movie.image ?? "",
                                  trailer: movie.trailer ?? "",
                                  synopsis: movie.synopsis ?? "")
            }
            
            if let safeMovie = movies.first(where: {(movie) in movie.key == key}) {
                self?.delegate?.didFetchMovies(movie: safeMovie)
            }
        }
        task.resume()
    }
    
    func getCharactersFrom(category: [Character]) -> [CharacterModel]{
        var characters: [CharacterModel] = []
        for character in category {
            characters.append(CharacterModel(character: character))
        }
        return characters
    }
}
