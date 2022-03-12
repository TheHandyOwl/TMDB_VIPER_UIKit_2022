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
}


// MARK: - MovieListLocalDataManagerInputProtocol
class MovieListLocalDataManager: MovieListLocalDataManagerInputProtocol {
    
    private var fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
    private var managedObjectContext: NSManagedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
    
    func addOrRemoveFavorite(movie: Movie, success: @escaping (() -> ()), failure: @escaping ((CoreDataErrors) -> ())) {
                
        guard let movieId32 = Int32(exactly: movie.movieID) else {
            failure(.overflowInt32)
            return
        }
        
        let newMovie = NSEntityDescription.insertNewObject(forEntityName: Constants.Managers.CoreData.favoriteMovieEntityName, into: managedObjectContext) as! FavoriteMovie
        
        newMovie.id = movieId32
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
    
}
