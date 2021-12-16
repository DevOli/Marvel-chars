//
//  MoviesViewModelTests.swift
//  MarvelCharsAppTests
//
//  Created by User on 12/14/21.
//

import XCTest
@testable import MarvelCharsApp

class MoviesViewModelTests: XCTestCase {

    var movieViewModel: MoviesViewModel!
    let mockedRepo = MockMarvelAPI()
    var refreshCallCount = 0
    var errorCallCount = 0
    
    
    
    override func setUpWithError() throws {

        movieViewModel = MoviesViewModel(repository: mockedRepo) { movie in
            self.refreshCallCount += 1 }
        errorHandler: { error in
            self.errorCallCount += 1
        }
    }

    func testGetMovieByCorrectKey() throws {
        let key = "iron-man-1"

        
        movieViewModel.getMovie(byKey: key)
        
        XCTAssertEqual(refreshCallCount, 1)
        XCTAssertEqual(movieViewModel.movie?.key, key)
    }
    
    func testGetMovieByInCorrectKey() throws {
        let key = "wrong-key"

        movieViewModel.getMovie(byKey: key)
        
        XCTAssertEqual(errorCallCount, 1)
        XCTAssertNil(movieViewModel.movie)
    }
    
    func testMovieViewModelInit() throws {
        let movieVM = MoviesViewModel()
        let error = CustomError.testError(message: "Fetch Data failed")
        let mockedMovie = mockedRepo.mockedMovieOne
        
        movieVM.refreshData(mockedMovie)
        movieVM.errorHandler(error)
        
        XCTAssertNotNil(movieVM.errorHandler, "Exists error handler")
        XCTAssertNotNil(movieVM.refreshData, "Exists success handler")
    }

}
