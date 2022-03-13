//
//  MovieListLocalDataManager.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 10/3/22.
//  
//

import CoreData
import Foundation


// MARK: - protocol MovieListLocalDataManagerInputProtocol
protocol MovieListLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
    func addOrRemoveFavorite(movie: Movie, success: @escaping (() -> ()), failure: @escaping ((CoreDataErrors) -> ()))
    func existsMovie(movie: Movie, success: @escaping ((Bool) -> ()), failure: @escaping ((CoreDataErrors) -> ()))
    func getFavoriteMovies() -> [Movie]?
}


// MARK: - MovieListLocalDataManager
final class MovieListLocalDataManager {
    
    private var fetchRequest: NSFetchRequest<CDFavorite> = CDFavorite.fetchRequest()
    private var managedObjectContext: NSManagedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
    
    private func addMovie(movie: Movie, success: @escaping (() -> ()), failure: @escaping ((CoreDataErrors) -> ())) {
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
    
    private func removeMovie(movie: Movie, success: @escaping (() -> ()), failure: @escaping ((CoreDataErrors) -> ())) {
        guard let movieID32 = Int32(exactly: movie.movieID) else {
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


// MARK: - MovieListLocalDataManagerInputProtocol
extension MovieListLocalDataManager: MovieListLocalDataManagerInputProtocol {
    
    func addOrRemoveFavorite(movie: Movie, success: @escaping (() -> ()), failure: @escaping ((CoreDataErrors) -> ())) {
        if movie.favorite {
            removeMovie(movie: movie, success: success, failure: failure)
        } else {
            addMovie(movie: movie, success: success, failure: failure)
        }
    }
    
    func existsMovie(movie: Movie, success: @escaping ((Bool) -> ()), failure: @escaping ((CoreDataErrors) -> ())) {
        
            guard let movieID32 = Int32(exactly: movie.movieID) else {
                failure(.overflowInt32)
                return
            }
            
            let predicate = NSPredicate(format: "%K = %@", #keyPath(CDFavorite.id), NSNumber(value: movieID32))
            fetchRequest.predicate = predicate
            do {
                let moviesFetched = try managedObjectContext.fetch(fetchRequest)
                let exists = moviesFetched.count > 0 ? true : false
                success(exists)
            } catch {
                failure(.searchError)
            }
        
    }
    
    func getFavoriteMovies() -> [Movie]? {
        
            do {
                let moviesFetched = try managedObjectContext.fetch(fetchRequest)
                let favoriteMovies = moviesFetched.compactMap { movie -> Movie? in
                    guard let id = Int(exactly: movie.id) else { return nil }
                    let image = movie.image ?? "No image"
                    let synopsis = movie.synopsis ?? "No synopsis"
                    let title = movie.title ?? "No title"
                    let favorite = true
                    
                    return Movie(movieID: id, title: title, synopsis: synopsis, image: image, favorite: favorite)
                }
                return favoriteMovies
            } catch let error {
                print("\(Constants.Strings.errorLiteral):\(error.localizedDescription)")
                return nil
            }
        
    }
    
}
