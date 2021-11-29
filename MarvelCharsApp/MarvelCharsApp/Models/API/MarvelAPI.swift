//
//  MarvelAPI.swift
//  MarvelCharsApp
//
//  Created by admin on 11/24/21.
//

import Foundation

protocol MarvelAPIDelegate {
    func didFetchData(categories: [CategoryModel])

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
    
    func getCharactersFrom(category: [Character]) -> [CharacterModel]{
        var characters: [CharacterModel] = []
        for character in category {
            characters.append(CharacterModel(character: character))
        }
        return characters
    }
}
