//
//  MarvelAPIModel.swift
//  MarvelCharsApp
//
//  Created by admin on 11/24/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let category = try? newJSONDecoder().decode(Category.self, from: jsonData)

import Foundation

// MARK: - CategoryElement
struct CategoryElement: Codable {
    let name, key: String
    let characterList: [Character]
}

// MARK: - CharacterList
struct Character: Codable {
    let name, alterEgo, imagePath, biography: String
    let caracteristics: Caracteristics
    let abilities: Abilities
    let movies: [String]
}

// MARK: - Abilities
struct Abilities: Codable {
    let force, intelligence, agility, endurance: Int
    let velocity: Int
}

// MARK: - Caracteristics
struct Caracteristics: Codable {
    let birth: String
    let weight, height: Eight
    let universe: Universe
}

// MARK: - Eight
struct Eight: Codable {
    let value: Double
    let unity: Unity
}

enum Unity: String, Codable {
    case kg = "kg"
    case meters = "meters"
}

enum Universe: String, Codable {
    case earth616 = "Earth 616"
}

typealias Category = [CategoryElement]

// MARK: - Shorter inits
extension Character {
  init(_ name: String, _ alterEgo: String, _ imagePath: String, _ biography: String, _ caracteristics: Caracteristics, _ abilities: Abilities, _ movies: [String]) {
    self.name = name
    self.alterEgo = alterEgo
    self.imagePath = imagePath
    self.biography = biography
    self.caracteristics = caracteristics
    self.abilities = abilities
    self.movies = movies
  }
}
extension Caracteristics {
  init(_ birth: String, _ weight: Eight, _ height: Eight, _ universe: Universe){
    self.birth = birth
    self.weight = weight
    self.height = height
    self.universe = universe
  }
}
extension Eight {
  init(_ value: Double, _ unity: Unity) {
    self.value = value
    self.unity = unity
  }
}
extension Abilities {
  init(_ force: Int, _ intelligence: Int, _ agility: Int, _ endurance: Int, _ velocity: Int){
    self.force = force
    self.intelligence = intelligence
    self.agility = agility
    self.endurance = endurance
    self.velocity = velocity
  }
}
