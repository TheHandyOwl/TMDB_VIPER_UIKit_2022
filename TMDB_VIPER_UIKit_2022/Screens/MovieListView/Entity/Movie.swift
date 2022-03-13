//
//  Movie.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 10/3/22.
//

import Foundation


// MARK: - Movie
struct Movie: Codable {
    
    let movieID: Int
    let title: String
    let synopsis: String
    let image: String
    var favorite: Bool
    
    init(movieID: Int, title: String, synopsis: String, image: String, favorite: Bool = false) {
        self.movieID = movieID
        self.title = title
        self.synopsis = synopsis
        self.image = image
        self.favorite = favorite
    }
    
}
