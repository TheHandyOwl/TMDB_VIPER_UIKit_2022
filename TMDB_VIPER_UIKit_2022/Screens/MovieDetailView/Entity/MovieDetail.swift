//
//  MovieDetail.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 11/3/22.
//

import Foundation


// MARK: - MovieDetail
struct MovieDetail: Codable {
    
    let movieID: Int
    
    let image: String
    let originalTitle: String
    let rating: String
    let releaseDate: String
    let synopsis: String
    let title: String
    
    init(movieID: Int, image: String, originalTitle: String, rating: String, releaseDate: String, synopsis: String, title: String) {
        self.movieID = movieID
        
        self.image = image
        self.originalTitle = originalTitle
        self.rating = rating
        self.releaseDate = releaseDate
        self.synopsis = synopsis
        self.title = title
    }
    
}
