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
    func removeFavorite(favorite: Movie, success: @escaping (() -> ()), failure: @escaping ((CoreDataErrors) -> ()))
}


// MARK: - FavoritesViewLocalDataManager
final class FavoritesViewLocalDataManager {
    
    private var fetchRequest: NSFetchRequest<CDFavorite> = CDFavorite.fetchRequest()
    private var searchResults: Array<CDFavorite> = []
    private var managedObjectContext: NSManagedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
    
    private func mapSearchResultsToMovies(searchResults: [CDFavorite]) -> [Movie] {
        searchResults.compactMap {
            guard let id = Int(exactly: $0.id) else { return nil }
            let image = $0.image ?? "No image"
            let synopsis = $0.synopsis ?? "No synopsis"
            let title = $0.title ?? "No title"
            let favorite = true
            
            return Movie(movieID: id, title: title, synopsis: synopsis, image: image, favorite: favorite)
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
    
    func removeFavorite(favorite: Movie, success: @escaping (() -> ()), failure: @escaping ((CoreDataErrors) -> ())) {
        
            guard let movieID32 = Int32(exactly: favorite.movieID) else {
                failure(.overflowInt32)
                return
            }
            
            let predicate = NSPredicate(format: "%K = %@", #keyPath(CDFavorite.id), NSNumber(value: movieID32))
            fetchRequest.predicate = predicate
            do {
                let moviesFetched = try managedObjectContext.fetch(fetchRequest)
                _ = moviesFetched.map { managedObjectContext.delete($0) }
                success()
            } catch {
                failure(.removeFavoriteMovie)
            }
        
    }
    
}
