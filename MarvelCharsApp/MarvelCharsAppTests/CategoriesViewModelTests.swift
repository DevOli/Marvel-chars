//
//  CategoriesViewModelTests.swift
//  MarvelCharsAppTests
//
//  Created by User on 30/11/21.
//

import XCTest
@testable import MarvelCharsApp

class CategoriesViewModelTests: XCTestCase {

    func testCategoriesViewModelCallsToTheRepositoryOnceWhenFetchingData() throws {
        let categoriesViewModel = CategoriesViewModel()
        let mockedRepository = MockedMarvelRepository()
        categoriesViewModel.repository = mockedRepository
        categoriesViewModel.repository.setDelegate(delegate: categoriesViewModel)
        categoriesViewModel.fetchData()
        XCTAssertEqual(1, mockedRepository.callsCount)
    }
    
    func testCategoriesFetchDataSuccessfullyAndStoresItInCategoryListVariable() throws {
        let categoriesViewModel = CategoriesViewModel()
        let mockedRepository = MockedMarvelRepository()
        categoriesViewModel.repository = mockedRepository
        categoriesViewModel.repository.setDelegate(delegate: categoriesViewModel)
        XCTAssertEqual(0, categoriesViewModel.countCategories())
        categoriesViewModel.fetchData()
        mockedRepository.fetchSuccessfully()
        XCTAssertEqual(5, categoriesViewModel.countCategories())
    }
    
    func testViewModelDelegateIsBeingCalledAfterFetchingData() throws {
        let mockedRepository = MockedMarvelRepository()
        let categoriesViewModel = CategoriesViewModel(repository: mockedRepository)
        let mockedDelegate = MockedCategoriesViewModelDelegate()
        categoriesViewModel.delegate = mockedDelegate
        
        categoriesViewModel.fetchData()
        mockedRepository.fetchSuccessfully()
        XCTAssertEqual(1, mockedDelegate.successCalls)
        XCTAssertEqual(5, mockedDelegate.lastResponse?.count)
        XCTAssertEqual(0, mockedDelegate.errorCalls)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}


class MockedMarvelRepository : MarvelRepository {

    var delegate: MarvelRepositoryDelegate?
    var callsCount: Int = 0
    
    func fetchData() {
        callsCount+=1
    }
    
    func setDelegate(delegate: MarvelRepositoryDelegate) {
        self.delegate = delegate
    }
    
    func fetchSuccessfully() {
        for _ in 1...callsCount {
            delegate?.didFetchData(categories: [CategoryModel(category: "Heroes"),CategoryModel(category: "Villians"),CategoryModel(category: "AntiHeroes"),CategoryModel(category: "Aliens"),CategoryModel(category: "Humans")])
        }
    }
}

class MockedCategoriesViewModelDelegate : CategoriesViewModelDelegate {
    var successCalls: Int = 0
    var errorCalls: Int = 0
    var lastResponse: [CategoryModel]?
    func didFetchSuccessfuly(categories: [CategoryModel]) {
        successCalls += 1
        lastResponse = categories
    }
    
    func didFailFetching(error: Error) {
        errorCalls += 1
    }
}
