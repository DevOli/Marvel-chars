//
//  MarvelAPI.swift
//  MarvelCharsApp
//
//  Created by admin on 11/24/21.
//

import Foundation

protocol MarvelAPIDelegate {
    func didFetchData(heroes: CategoryModel, villains: CategoryModel,
                      antiHeroes: CategoryModel, aliens: CategoryModel, humans: CategoryModel)
}

class MarvelAPI {
    
    private let baseURL = "https://619d463f131c600017088e71.mockapi.io/api/v1/characters"
    var delegate: MarvelAPIDelegate?
    
    func fetchData() {
        let urlString = baseURL
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
            let marvelAPI = try? decoder.decode(Marvel.self, from: safeData)
            guard let results = marvelAPI?[0] else {
                return
            }
            let heroes = self?.getCharactersFrom(category: results.heroes)
            let villains = self?.getCharactersFrom(category: results.villains)
            let antiHeroes = self?.getCharactersFrom(category: results.antiHeroes)
            let aliens = self?.getCharactersFrom(category: results.aliens)
            let humans = self?.getCharactersFrom(category: results.humans)
            
            self?.delegate?.didFetchData(heroes: CategoryModel(category: "heroes", characters: heroes!),
                                         villains: CategoryModel(category: "villains", characters: villains!),
                                         antiHeroes: CategoryModel(category: "antiHeroes", characters: antiHeroes!),
                                         aliens: CategoryModel(category: "aliens", characters: aliens!),
                                         humans: CategoryModel(category: "humans", characters: humans!))
             
        }
        task.resume()
    }
    
    func getCharactersFrom(category: [Alien]) -> [CharacterModel]{
        var characters: [CharacterModel] = []
        for character in category {
            characters.append(CharacterModel(character: character))
        }
        return characters
    }
    
}
