//
//  CategoryModelTest.swift
//  MarvelCharsAppTests
//
//  Created by admin on 11/30/21.
//

import XCTest

class CategoryModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

  func testSetPropertiesCorrectly() throws {
    let characteristics = Caracteristics("01-01-2000", Eight(70.0, .kg), Eight(170.0, .meters), .earth616)
    let abilities = Abilities(100, 90, 80, 70, 60)
    let category = CategoryModel(category: "Heroes", characters: [
      CharacterModel(character: Character("SpiderMan", "Peter Parker", "spidey.png", "bio", characteristics, abilities, ["avengers","homecoming"])),
      CharacterModel(character: Character("IronMan", "Tony Stark", "ironman.png", "bio", characteristics, abilities, ["avengers","ironman1"]))
    ])
    XCTAssertEqual(category.characters[1].intelligence, 90)
    XCTAssertEqual(category.category, "Heroes")
    XCTAssertEqual(category.characters[0].movies[0], "avengers")
  }
  
  func testIsCharactersEmptyWhenNotSet() throws {
    let category = CategoryModel(category: "Heroes")
    XCTAssertTrue(category.characters.isEmpty)
  }
  
  func testReturnsCharactersCountWhenSet() throws {
    let characteristics = Caracteristics("01-01-2000", Eight(70.0, .kg), Eight(170.0, .meters), .earth616)
    let abilities = Abilities(100, 90, 80, 70, 60)
    let category = CategoryModel(category: "Heroes", characters: [
      CharacterModel(character: Character("SpiderMan", "Peter Parker", "spidey.png", "bio", characteristics, abilities, ["avengers","homecoming"])),
      CharacterModel(character: Character("IronMan", "Tony Stark", "ironman.png", "bio", characteristics, abilities, ["avengers","ironman1"]))
    ])
    XCTAssertEqual(category.charactersCount, 2)
  }
  
  func testReturnsZeroForCharactersCountWhenNotSet() throws {
    let category = CategoryModel(category: "Heroes")
    XCTAssertEqual(category.charactersCount, 0)
  }
  
  func testGetCharacterCorrectly() throws {
    let characteristics = Caracteristics("01-01-2000", Eight(70.0, .kg), Eight(170.0, .meters), .earth616)
    let abilities = Abilities(100, 90, 80, 70, 60)
    let category = CategoryModel(category: "Heroes", characters: [
      CharacterModel(character: Character("SpiderMan", "Peter Parker", "spidey.png", "bio", characteristics, abilities, ["avengers","homecoming"])),
      CharacterModel(character: Character("IronMan", "Tony Stark", "ironman.png", "bio", characteristics, abilities, ["avengers","ironman1"]))
    ])
    let character = category.getCharacter(at: 1)
    XCTAssertEqual(character?.alterEgo, "Tony Stark")
  }
  
  func testGetCharacterThrowsErrorWhenNotSet() throws {
    let category = CategoryModel(category: "Heroes")
    XCTAssertNil(category.getCharacter(at: 0))
  }
  
  func testGetCharacterThrowsErrorWhenIndexOutOfRange() throws {
    let characteristics = Caracteristics("01-01-2000", Eight(70.0, .kg), Eight(170.0, .meters), .earth616)
    let abilities = Abilities(100, 90, 80, 70, 60)
    let category = CategoryModel(category: "Heroes", characters: [
      CharacterModel(character: Character("SpiderMan", "Peter Parker", "spidey.png", "bio", characteristics, abilities, ["avengers","homecoming"])),
      CharacterModel(character: Character("IronMan", "Tony Stark", "ironman.png", "bio", characteristics, abilities, ["avengers","ironman1"]))
    ])
    XCTAssertNil(category.getCharacter(at: 10))
  }

}

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
