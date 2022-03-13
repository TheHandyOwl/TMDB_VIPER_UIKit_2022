//
//  Errors.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 10/3/22.
//

import Foundation


// MARK: - CoreDataErrors
enum CoreDataErrors: Error {
    case contextWithoutChanges
    case fetchingRequest
    case insertFavoriteMovie
    case noManagedObjectContext
    case overflowInt32
    case removeFavoriteMovie
    case searchError
    case unknownError
}


// MARK: - NetworkErrors
enum NetworkErrors: Error {
    case dataError
    case decodingImage
    case decodingJSONError
    case mappingError
    case networkError
    case noRequest
    case pageLimitReached
    case responseError
    case statusCode401UnauthorizedError
    case statusCode403ForbiddenError
    case statusCode404NotFoundError
    case statusCodeGenericError
    case unknownError
    case urlError
}
