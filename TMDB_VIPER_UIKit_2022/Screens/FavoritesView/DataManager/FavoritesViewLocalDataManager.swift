//
//  FavoritesViewLocalDataManager.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 11/3/22.
//  
//

import CoreData
import Foundation


// MARK: - protocol FavoritesViewLocalDataManagerInputProtocol
protocol FavoritesViewLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
    func getFavorites(success: @escaping (([Movie]) -> ()), failure: @escaping ((CoreDataErrors) -> ()))
    func removeFavorite(favorite: Int, success: @escaping (() -> ()), failure: @escaping ((CoreDataErrors) -> ()))
}


// MARK: - FavoritesViewLocalDataManager
class FavoritesViewLocalDataManager {
    
    private var fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
    private var searchResults: Array<FavoriteMovie> = []
    private var managedObjectContext: NSManagedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
    
    private func mapSearchResultsToMovies(searchResults: [FavoriteMovie]) -> [Movie] {
        searchResults.compactMap {
            guard let id = Int(exactly: $0.id) else { return nil }
            let image = $0.image ?? "No image"
            let synopsis = $0.synopsis ?? "No synopsis"
            let title = $0.title ?? "No title"
            
            return Movie(movieID: id, title: title, synopsis: synopsis, image: image)
        }
    }
    
}


// MARK: - FavoritesViewLocalDataManagerInputProtocol
extension FavoritesViewLocalDataManager: FavoritesViewLocalDataManagerInputProtocol {
    
    func getFavorites(success: @escaping (([Movie]) -> ()), failure: @escaping ((CoreDataErrors) -> ())) {
        
        do {
            searchResults = try managedObjectContext.fetch(fetchRequest)
            let favorites = mapSearchResultsToMovies(searchResults: searchResults)
            success(favorites)
        } catch let error {
            print("\(Constants.Strings.errorLiteral): \(error.localizedDescription)")
            failure(.fetchingRequest)
        }
        
    }
    
    func removeFavorite(favorite: Int, success: @escaping (() -> ()), failure: @escaping ((CoreDataErrors) -> ())) {
        // TODO: Implement use case methods
        success()
    }
    
}
