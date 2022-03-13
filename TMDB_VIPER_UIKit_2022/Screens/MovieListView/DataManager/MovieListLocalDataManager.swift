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
    func getFavoriteMovies() -> [Movie]?
}


// MARK: - MovieListLocalDataManager
final class MovieListLocalDataManager {
    
    private var fetchRequest: NSFetchRequest<CDFavorite> = CDFavorite.fetchRequest()
    private var managedObjectContext: NSManagedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
    
}


// MARK: - MovieListLocalDataManagerInputProtocol
extension MovieListLocalDataManager: MovieListLocalDataManagerInputProtocol {
    
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
