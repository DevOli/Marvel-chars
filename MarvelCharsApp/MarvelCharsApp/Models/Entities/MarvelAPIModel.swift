//
//  MarvelAPIModel.swift
//  MarvelCharsApp
//
//  Created by admin on 11/24/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let marvel = try? newJSONDecoder().decode(Marvel.self, from: jsonData)

import Foundation

// MARK: - MarvelElement
struct MarvelElement: Codable {
    let heroes, villains, antiHeroes, aliens: [Alien]
    let humans: [Alien]
}

// MARK: - Alien
struct Alien: Codable {
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
    case terra616 = "Terra 616"
}

typealias Marvel = [MarvelElement]
