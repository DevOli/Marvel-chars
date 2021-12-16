//
//  SearchViewModelTests.swift
//  MarvelCharsAppTests
//
//  Created by User on 11/30/21.
//

import XCTest
@testable import MarvelCharsApp

class SearchViewModelTests: XCTestCase {
    var mockedRepo = MockMarvelAPI()
    var search = SearchViewModel(repository: MockMarvelAPI())
    var refreshCallsCount = 0
    
    override func setUpWithError() throws {
        search.refreshData = {
            self.refreshCallsCount += 1
        }
        
        search.getAllcharacters()
    }
    
    override func tearDownWithError() throws {
    }
    
    func testGetAllCharacters() throws {
        let count = self.search.count()
        XCTAssertEqual(1, self.refreshCallsCount)
        XCTAssertEqual(3, count)
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
        search.getCharacters(byName: "SpiderManTest")
        let count = search.count()
        XCTAssertEqual(2, refreshCallsCount)
        XCTAssertGreaterThan(count, 0)
    }
    
    func testGetCharacterByInCorrectName() throws {
        search.getCharacters(byName: "Wrong Name")
        let count = search.count()
        XCTAssertEqual(2, refreshCallsCount)
        XCTAssertEqual(0, count)
    }
    
    func testGetCharacterByEmptyName() throws {
        search.getCharacters(byName: "")
        let count = search.count()
        XCTAssertEqual(2, refreshCallsCount)
        XCTAssertEqual(3, count)
    }
}
