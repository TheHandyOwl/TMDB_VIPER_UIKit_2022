//
//  MoviesResponse.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 10/3/22.
//

import Foundation

// MARK: - MoviesResponse
struct MoviesResponse: Codable {
    
    let page: Int
    let results: [MovieResponse]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
}

// MARK: - MovieResponse
struct MovieResponse: Codable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalTitle: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let synopsis: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case synopsis = "overview"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
