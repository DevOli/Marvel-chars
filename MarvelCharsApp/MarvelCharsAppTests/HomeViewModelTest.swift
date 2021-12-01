//
//  HomeViewModelTest.swift
//  MarvelCharsAppTests
//
//  Created by admin on 11/30/21.
//

import XCTest

class HomeViewModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

  func testGetCategoryWithName() throws {
    let viewModel = HomeViewModel()
    let mockedManager = MockedMarvelAPI()
    viewModel.setManager(manager: mockedManager)
    viewModel.fetchData()
    let category = viewModel.getCategoryWith(name: "AntiHeroes")
    XCTAssertEqual(category?.category, "AntiHeroes")
  }
  
  func testReturnNilWhenGetCategoryWithWrongName() throws {
    let viewModel = HomeViewModel()
    let mockedManager = MockedMarvelAPI()
    viewModel.setManager(manager: mockedManager)
    viewModel.fetchData()
    let category = viewModel.getCategoryWith(name: "Antiheroes")
    XCTAssertNil(category)
  }
  
  func testReturnNilWhenGetCategoryWithNameAndDidntFetchData() throws {
    let viewModel = HomeViewModel()
    let mockedManager = MockedMarvelAPI()
    viewModel.setManager(manager: mockedManager)
    let category = viewModel.getCategoryWith(name: "")
    XCTAssertNil(category)
  }

}

class MockedMarvelAPI: MarvelAPI {
  
  override func fetchData() {
    var categories: [CategoryModel] = []
    categories.append(CategoryModel(category: "Heroes"))
    categories.append(CategoryModel(category: "AntiHeroes"))
    categories.append(CategoryModel(category: "Humans"))
    self.delegate?.didFetchData(categories: categories)
  }
  
}
