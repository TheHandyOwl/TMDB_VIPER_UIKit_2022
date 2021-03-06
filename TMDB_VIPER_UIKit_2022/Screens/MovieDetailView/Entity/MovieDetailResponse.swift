//
//  MovieDetailResponse.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 11/3/22.
//

import Foundation


// MARK: - MovieDetailResponse
struct MovieDetailResponse: Codable {
    let adult: Bool
    let backdropPath: String
//    let belongsToCollection: BelongsToCollection
    let budget: Int
//    let genres: [Genre]
    let homepage: String
    let id: Int
    let imdbID, originalLanguage, originalTitle: String
    let popularity: Double
    let posterPath: String
//    let productionCompanies: [ProductionCompany]
//    let productionCountries: [ProductionCountry]
    let releaseDate: String
    let revenue, runtime: Int
//    let spokenLanguages: [SpokenLanguage]
    let status, tagline, title: String
    let synopsis: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
//        case belongsToCollection = "belongs_to_collection"
        case budget
//        case genres
        case homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case popularity
        case posterPath = "poster_path"
//        case productionCompanies = "production_companies"
//        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
//        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case synopsis = "overview"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

/*
// MARK: - BelongsToCollection
struct BelongsToCollection: Codable {
    let id: Int
    let name, posterPath, backdropPath: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

// MARK: - Genre
struct localityGenre: Codable {
    let id: Int
    let name: String
}

// MARK: - ProductionCompany
struct localityProductionCompany: Codable {
    let id: Int
    let logoPath, name, originCountry: String

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

// MARK: - ProductionCountry
struct localityProductionCountry: Codable {
    let iso3166_1, name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

// MARK: - SpokenLanguage
struct localitySpokenLanguage: Codable {
    let englishName, iso639_1, name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}
*/
