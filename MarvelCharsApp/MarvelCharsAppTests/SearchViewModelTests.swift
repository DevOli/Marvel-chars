//
//  SearchViewModelTests.swift
//  MarvelCharsAppTests
//
//  Created by User on 11/30/21.
//

import XCTest
@testable import MarvelCharsApp

class SearchViewModelTests: XCTestCase {
    var search = SearchViewModel()
    var refreshCallsCount = 0
    
    
    func prepareAndWaitFirstFetchExpectation() {
        let expectationForFecthAll = self.expectation(description: "Request to API")
        search.refreshData = {
            self.refreshCallsCount += 1
            expectationForFecthAll.fulfill()
        }
        search.getAllcharacters()
        self.waitForExpectations(timeout: 2, handler: nil)
    }
    
    func prepareSearchlocalExpectation() {
        let expectationForSearch = self.expectation(description: "Search locally")
        search.refreshData = {
            self.refreshCallsCount += 1
            expectationForSearch.fulfill()
        }
    }
    
    override func setUpWithError() throws {
        prepareAndWaitFirstFetchExpectation()
    }
    
    override func tearDownWithError() throws {
        refreshCallsCount = 0
    }
    
    func testGetAllCharacters() throws {
        let count = self.search.count()
        XCTAssertEqual(1, self.refreshCallsCount)
        XCTAssertEqual(15, count)
    }
    
    func testCountFunction() throws {
        let count = search.count()
        XCTAssertGreaterThan(count, 0)
    }
    
    func testGetCharacterByIndex() throws {
        let items = search.get(byIndex: 0)
        XCTAssertNotNil(items)
    }
    
    func testGetCharacterByCorrectName() throws {
        prepareSearchlocalExpectation()
        search.getCharacters(byName: "Spider Man")
        self.waitForExpectations(timeout: 2, handler: nil)
        let count = search.count()
        XCTAssertEqual(2, refreshCallsCount)
        XCTAssertGreaterThan(count, 0)
    }
    
    func testGetCharacterByInCorrectName() throws {
        prepareSearchlocalExpectation()
        search.getCharacters(byName: "Wrong Name")
        self.waitForExpectations(timeout: 2, handler: nil)
        let count = search.count()
        XCTAssertEqual(2, refreshCallsCount)
        XCTAssertEqual(0, count)
    }
    
    func testGetCharacterByEmptyName() throws {
        prepareSearchlocalExpectation()
        search.getCharacters(byName: "")
        self.waitForExpectations(timeout: 2, handler: nil)
        let count = search.count()
        XCTAssertEqual(2, refreshCallsCount)
        XCTAssertEqual(15, count)
    }
}

//Not using mock in this test
class MockMarvelAPI {
    
    var delegate: MarvelRepositoryDelegate?
    
    let characterOne = CharacterModel(name: "SpidermanTest", alterEgo: "AlterEgoTest", imagePath: "", biography: "", birth: "", weight: 0, weightUnit: "", height: 0, heightUnit: "", universe: "", force: 0, intelligence: 0, agility: 0, endurance: 0, velocity: 0, movies: [])
    let characterTwo = CharacterModel(name: "IronManTest", alterEgo: "AlterEgoTest", imagePath: "", biography: "", birth: "", weight: 0, weightUnit: "", height: 0, heightUnit: "", universe: "", force: 0, intelligence: 0, agility: 0, endurance: 0, velocity: 0, movies: [])
    let characterThree = CharacterModel(name: "DeadPoolTest", alterEgo: "AlterEgoTest", imagePath: "", biography: "", birth: "", weight: 0, weightUnit: "", height: 0, heightUnit: "", universe: "", force: 0, intelligence: 0, agility: 0, endurance: 0, velocity: 0, movies: [])
    
    func fetchData() {
        let categories = [CategoryModel(category: "CategoryTest", characters: [characterOne, characterTwo, characterThree])]
        self.delegate?.didFetchData(categories: categories)
    }
}
