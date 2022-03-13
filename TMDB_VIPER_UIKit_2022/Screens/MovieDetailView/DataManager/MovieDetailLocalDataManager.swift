//
//  MovieDetailLocalDataManager.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 11/3/22.
//  
//

import CoreData
import Foundation


// MARK:
protocol MovieDetailLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
    func addOrRemoveFavorite(state: Bool, movieDetail: MovieDetail, success: @escaping (() -> ()), failure: @escaping ((CoreDataErrors) -> ()))
    func existsMovie(movieID: Int) -> Bool
}


// MARK: - MovieDetailLocalDataManager
final class MovieDetailLocalDataManager {
    
    private var fetchRequest: NSFetchRequest<CDFavorite> = CDFavorite.fetchRequest()
    private var managedObjectContext: NSManagedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
    
    private func addMovie(movie: MovieDetail, success: @escaping (() -> ()), failure: @escaping ((CoreDataErrors) -> ())) {
        guard let movieID32 = Int32(exactly: movie.movieID) else {
            failure(.overflowInt32)
            return
        }
        
        let newMovie = NSEntityDescription.insertNewObject(forEntityName: Constants.Managers.CoreData.favoriteMovieEntityName, into: managedObjectContext) as! CDFavorite
        
        newMovie.id = movieID32
        newMovie.image = movie.image
        newMovie.synopsis = movie.synopsis
        newMovie.title = movie.title
        
        do {
            if managedObjectContext.hasChanges {
                try managedObjectContext.performAndWait {
                    try CoreDataManager.shared.saveContext()
                    success()
                }
            } else {
                failure(.contextWithoutChanges)
            }
        } catch {
            failure(.insertFavoriteMovie)
        }
    }
    
    private func removeMovie(movie: MovieDetail, success: @escaping (() -> ()), failure: @escaping ((CoreDataErrors) -> ())) {
        guard let movieID32 = Int32(exactly: movie.movieID) else {
            failure(.overflowInt32)
            return
        }
        
        let predicate = NSPredicate(format: "%K = %@", #keyPath(CDFavorite.id), NSNumber(value: movieID32))
        fetchRequest.predicate = predicate
        do {
            let moviesFetched = try managedObjectContext.fetch(fetchRequest)
            _ = moviesFetched.map { managedObjectContext.delete($0) }
            try CoreDataManager.shared.saveContext()
            success()
        } catch {
            failure(.removeFavoriteMovie)
        }
    }
    
}


// MARK: - MovieDetailLocalDataManagerInputProtocol
extension MovieDetailLocalDataManager: MovieDetailLocalDataManagerInputProtocol {
    
    func addOrRemoveFavorite(state: Bool, movieDetail: MovieDetail, success: @escaping (() -> ()), failure: @escaping ((CoreDataErrors) -> ())) {
        if state {
            addMovie(movie: movieDetail, success: success, failure: failure)
        } else {
            removeMovie(movie: movieDetail, success: success, failure: failure)
        }
    }
    
    func existsMovie(movieID: Int) -> Bool {
        
            guard let movieID32 = Int32(exactly: movieID) else {
                return false
            }
            
            let predicate = NSPredicate(format: "%K = %@", #keyPath(CDFavorite.id), NSNumber(value: movieID32))
            fetchRequest.predicate = predicate
            do {
                let moviesFetched = try managedObjectContext.fetch(fetchRequest)
                let exists = moviesFetched.count > 0 ? true : false
                return exists
            } catch {
                return false
            }
        
    }
    
}
