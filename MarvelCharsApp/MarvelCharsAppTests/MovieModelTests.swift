//
//  MovieModelTests.swift
//  MarvelCharsAppTests
//
//  Created by User on 12/14/21.
//

import XCTest
@testable import MarvelCharsApp

class MovieModelTests: XCTestCase {

    func testInitCorrectly() throws {
        let name = "Iron Man"
        let key = "iron-man-1"
        let image = "iron-man-1"
        let trailer = "https://www.youtube.com/watch?v=8ugaeA-nMTc"
        let synopsis = "A billionaire industrialist ..."
        
        let movie = MovieModel(name: name, key: key, image: image, trailer: trailer, synopsis: synopsis)
        
        XCTAssertEqual(movie.name, name)
        XCTAssertEqual(movie.key, key)
        XCTAssertEqual(movie.image, image)
        XCTAssertEqual(movie.trailer, trailer)
        XCTAssertEqual(movie.synopsis, synopsis)
    }
    
    func testMutateTrailerURL() throws {
        let name = "Iron Man"
        let key = "iron-man-1"
        let image = "iron-man-1"
        let trailer = "https://www.youtube.com/watch?v=8ugaeA-nMTc"
        let embedTrailer = "https://www.youtube.com/embed/8ugaeA-nMTc"
        let synopsis = "A billionaire industrialist ..."
        
        var movie = MovieModel(name: name, key: key, image: image, trailer: trailer, synopsis: synopsis)
        movie.embedUrlTrailer()
        
        XCTAssertEqual(movie.name, name)
        XCTAssertEqual(movie.key, key)
        XCTAssertEqual(movie.image, image)
        XCTAssertEqual(movie.trailer, embedTrailer)
        XCTAssertEqual(movie.synopsis, synopsis)
    }

}
