//
//  FavoritesViewInteractor.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 11/3/22.
//  
//

import Foundation


// MARK: - protocol FavoritesViewInteractorInputProtocol
protocol FavoritesViewInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: FavoritesViewInteractorOutputProtocol? { get set }
    var localDatamanager: FavoritesViewLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: FavoritesViewRemoteDataManagerInputProtocol? { get set }
    
    func getFavorites(success: @escaping (([Movie]) -> ()), failure: @escaping ((CoreDataErrors) -> ()))
}


// MARK: - protocol FavoritesViewLocalDataManagerOutputProtocol
protocol FavoritesViewLocalDataManagerOutputProtocol: AnyObject {
    // LOCALDATAMANAGER -> INTERACTOR
}


// MARK: - FavoritesViewRemoteDataManagerOutputProtocol
protocol FavoritesViewRemoteDataManagerOutputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
}


// MARK: - FavoritesViewInteractorInputProtocol
final class FavoritesViewInteractor: FavoritesViewInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: FavoritesViewInteractorOutputProtocol?
    var localDatamanager: FavoritesViewLocalDataManagerInputProtocol?
    var remoteDatamanager: FavoritesViewRemoteDataManagerInputProtocol?
    
    func getFavorites(success: @escaping (([Movie]) -> ()), failure: @escaping ((CoreDataErrors) -> ())) {
        localDatamanager?.getFavorites(success: success, failure: failure)
    }
    
}


// MARK: - FavoritesViewLocalDataManagerOutputProtocol
extension FavoritesViewInteractor: FavoritesViewLocalDataManagerOutputProtocol {
}
