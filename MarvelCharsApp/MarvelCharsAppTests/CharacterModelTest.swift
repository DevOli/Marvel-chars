//
//  CharacterModelTest.swift
//  MarvelCharsAppTests
//
//  Created by admin on 12/1/21.
//

import XCTest
@testable import MarvelCharsApp

class CharacterModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

  func testSetPropertiesCorrectlyWithCharacterStruct() throws {
    let characteristics = Caracteristics("01-01-2000", Eight(70.0, .kilograms), Eight(170.0, .meters), .earth616)
    let abilities = Abilities(100, 90, 80, 70, 60)
    let character = CharacterModel(character: Character("SpiderMan", "Peter Parker", "spidey.png", "bio",
                                                        characteristics, abilities, ["avengers", "homecoming"]))
    XCTAssertEqual(character.intelligence, 90)
    XCTAssertEqual(character.movies[0], "avengers")
  }

  func testSetPropertiesCorrectly() throws {
    let character = CharacterModel(name: "SpiderMan", alterEgo: "Peter Parker", imagePath: "spidey.png",
                                   biography: "bio", birth: "01-01-2000", weight: 70.0, weightUnit: "kg",
                                   height: 170.0, heightUnit: "meters", universe: "Earth 616", force: 100,
                                   intelligence: 90, agility: 80, endurance: 70, velocity: 60,
                                   movies: ["avengers", "homecoming"])
    XCTAssertEqual(character.intelligence, 90)
    XCTAssertEqual(character.movies[0], "avengers")
  }
  
  func testGetMovieKeyCorrectly() throws {
    let character = CharacterModel(name: "SpiderMan", alterEgo: "Peter Parker", imagePath: "spidey.png", biography: "bio", birth: "01-01-2000", weight: 70.0, weightUnit: "kg", height: 170.0, heightUnit: "meters", universe: "Earth 616", force: 100, intelligence: 90, agility: 80, endurance: 70, velocity: 60, movies: ["https://i.bb.com/QWERTY/avengers-3.png", "https://i.bb.com/QWERTY/spider-man-homecoming.png"])
    let movieKey = character.getMovieKeyFromURL(at: 0)
    XCTAssertEqual(movieKey, "avengers-3")
  }
  
  func testGetMovieKeyReturnsNilWhenIndexOutOfRange() throws {
    let character = CharacterModel(name: "SpiderMan", alterEgo: "Peter Parker", imagePath: "spidey.png", biography: "bio", birth: "01-01-2000", weight: 70.0, weightUnit: "kg", height: 170.0, heightUnit: "meters", universe: "Earth 616", force: 100, intelligence: 90, agility: 80, endurance: 70, velocity: 60, movies: ["https://i.bb.com/QWERTY/avengers-3.png", "https://i.bb.com/QWERTY/spider-man-homecoming.png"])
    XCTAssertNil(character.getMovieKeyFromURL(at: 10))
  }

}
