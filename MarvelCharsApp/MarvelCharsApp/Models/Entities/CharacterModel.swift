//
//  CharacterModel.swift
//  MarvelCharsApp
//
//  Created by admin on 11/24/21.
//

import Foundation
struct CharacterModel {
    
    let name: String
    let alterEgo: String
    let imagePath: String
    let biography: String
    let birth: String
    let weight: Double
    let weightUnit: String
    let height: Double
    let heightUnit: String
    let universe: String
    let force: Int
    let intelligence: Int
    let agility: Int
    let endurance: Int
    let velocity: Int
    let movies: [String]
    
    init(character: CharacterList){
        self.init(name: character.name, alterEgo: character.alterEgo, imagePath: character.imagePath,
                  biography: character.biography, birth: character.caracteristics.birth, weight: character.caracteristics.weight.value,
                  weightUnit: character.caracteristics.weight.unity.rawValue, height: character.caracteristics.height.value,
                  heightUnit: character.caracteristics.height.unity.rawValue, universe: character.caracteristics.universe.rawValue,
                  force: character.abilities.force, intelligence: character.abilities.intelligence, agility: character.abilities.agility,
                  endurance: character.abilities.endurance, velocity: character.abilities.velocity, movies: character.movies)
    }
    
    init(name: String, alterEgo: String, imagePath: String, biography: String, birth: String, weight: Double,
         weightUnit: String, height: Double, heightUnit: String, universe: String, force: Int,
         intelligence: Int, agility: Int, endurance: Int, velocity: Int, movies: [String]) {
        self.name = name
        self.alterEgo = alterEgo
        self.imagePath = imagePath
        self.biography = biography
        self.birth = birth
        self.weight = weight
        self.weightUnit = weightUnit
        self.height = height
        self.heightUnit = heightUnit
        self.universe = universe
        self.force = force
        self.intelligence = intelligence
        self.agility = agility
        self.endurance = endurance
        self.velocity = velocity
        self.movies = movies
    }
}
