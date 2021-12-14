//
//  MovieModel.swift
//  MarvelCharsApp
//
//  Created by User on 12/13/21.
//

import Foundation
struct MovieModel {
    let name, key, image: String
    var trailer: String
    let synopsis: String

    mutating func embedUrlTrailer() {
        if trailer.contains("/watch?v=") {
            trailer = trailer.replacingOccurrences(of: "/watch?v=", with: "/embed/")
        }
    }
}
