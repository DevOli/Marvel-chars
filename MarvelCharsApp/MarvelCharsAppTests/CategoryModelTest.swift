//
//  CategoryModelTest.swift
//  MarvelCharsAppTests
//
//  Created by admin on 11/30/21.
//

import XCTest
@testable import MarvelCharsApp

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
  
  func testGetCharacterReturnsNilWhenNotSet() throws {
    let category = CategoryModel(category: "Heroes")
    XCTAssertNil(category.getCharacter(at: 0))
  }
  
  func testGetCharacterReturnsNilWhenIndexOutOfRange() throws {
    let characteristics = Caracteristics("01-01-2000", Eight(70.0, .kg), Eight(170.0, .meters), .earth616)
    let abilities = Abilities(100, 90, 80, 70, 60)
    let category = CategoryModel(category: "Heroes", characters: [
      CharacterModel(character: Character("SpiderMan", "Peter Parker", "spidey.png", "bio", characteristics, abilities, ["avengers","homecoming"])),
      CharacterModel(character: Character("IronMan", "Tony Stark", "ironman.png", "bio", characteristics, abilities, ["avengers","ironman1"]))
    ])
    XCTAssertNil(category.getCharacter(at: 10))
  }

}
