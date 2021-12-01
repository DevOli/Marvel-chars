//
//  CategoryModel.swift
//  MarvelCharsApp
//
//  Created by admin on 11/25/21.
//

import Foundation
struct CategoryModel {
    var characters: [CharacterModel]
    let category: String
    init(category: String) {
        self.category = category
        self.characters = []
    }
    init(category: String, characters: [CharacterModel]) {
        self.category = category
        self.characters = characters
    }
    var charactersCount: Int {
        return self.characters.count
    }
    func getCharacter(at index: Int) -> CharacterModel? {
      if index<0 || index>=charactersCount || characters.isEmpty {
        return nil
      }
      return self.characters[index]
    }
}
