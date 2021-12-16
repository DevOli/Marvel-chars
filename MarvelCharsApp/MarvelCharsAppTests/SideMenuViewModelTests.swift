//
//  CategoriesViewModelTests.swift
//  MarvelCharsAppTests
//
//  Created by User on 30/11/21.
//

import XCTest
@testable import MarvelCharsApp

class SideMenuViewModelTests: XCTestCase {

    func testSideMenuViewModelCallsToTheRepositoryOnceWhenFetchingData() throws {
        let sideMenuViewModel = SideMenuViewModel()
        let mockedRepository = MockedMarvelRepository()
        sideMenuViewModel.repository = mockedRepository
        sideMenuViewModel.repository.setDelegate(delegate: sideMenuViewModel)
        sideMenuViewModel.fetchData()
        XCTAssertEqual(1, mockedRepository.callsCount)
    }
    
    func testSideMenuFetchDataSuccessfullyAndStoresItInCategoryListVariable() throws {
        let sideMenuViewModel = SideMenuViewModel()
        let mockedRepository = MockedMarvelRepository()
        sideMenuViewModel.repository = mockedRepository
        sideMenuViewModel.repository.setDelegate(delegate: sideMenuViewModel)
        XCTAssertEqual(0, sideMenuViewModel.countCategories())
        sideMenuViewModel.fetchData()
        XCTAssertEqual(5, sideMenuViewModel.countCategories())
    }
    
    func testSideMenuViewModelDelegateIsBeingCalledAfterFetchingData() throws {
        let mockedRepository = MockedMarvelRepository()
        let sideMenuViewModel = SideMenuViewModel(repository: mockedRepository)
        let mockedDelegate = MockedSideMenuViewModelDelegate()
        sideMenuViewModel.delegate = mockedDelegate
        sideMenuViewModel.fetchData()

        XCTAssertEqual(1, mockedDelegate.successCalls)
        XCTAssertEqual(5, mockedDelegate.lastResponse?.count)
        XCTAssertEqual(0, mockedDelegate.errorCalls)
    }
    
}


class MockedMarvelRepository : MarvelRepository {
    
    var delegate: MarvelRepositoryDelegate?
    var callsCount: Int = 0
    
    func fetchMovie(byKey: String) {
        
    }
    
    func setDelegate(forMovie: MarvelMoviesDelegate) {
        
    }
    
    func fetchData() {
        callsCount+=1
        fetchSuccessfully()
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

class MockedSideMenuViewModelDelegate : SideMenuViewModelDelegate {
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
