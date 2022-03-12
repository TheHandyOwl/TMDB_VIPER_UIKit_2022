//
//  FavoritesViewPresenter.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 11/3/22.
//  
//

import Foundation


// MARK: - protocol FavoritesViewPresenterProtocol
protocol FavoritesViewPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: FavoritesViewProtocol? { get set }
    var interactor: FavoritesViewInteractorInputProtocol? { get set }
    var wireFrame: FavoritesViewWireFrameProtocol? { get set }
    
    var favoritesData: [String] { get }
    
    func removeFavorite(movieId: String)
    func viewDidLoad()
}


// MARK: - protocol FavoritesViewInteractorOutputProtocol
protocol FavoritesViewInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}


// MARK: - FavoritesViewPresenter
class FavoritesViewPresenter {
    
    // MARK: Properties
    weak var view: FavoritesViewProtocol?
    var interactor: FavoritesViewInteractorInputProtocol?
    var wireFrame: FavoritesViewWireFrameProtocol?

    var favoritesData: [String] {
        return favorites
    }
    
    private var favorites = [String]()
    
    private func getFavorites() {
        sleep(5)
        favorites = ["Spiderman", "Batman", "Eternals", "6 en la sombra"]
        view?.refreshData(favorites: favorites)
        view?.stopActivity()
    }
    
}


// MARK: - FavoritesViewPresenterProtocol
extension FavoritesViewPresenter: FavoritesViewPresenterProtocol {
    
    func removeFavorite(movieId: String) {
        favorites = favorites.filter { $0 != movieId }
        view?.refreshData(favorites: favorites)
    }
    
    func viewDidLoad() {
        view?.setupUI(withTitle: Constants.Views.Favorites.title)
        self.view?.startActivity()
        DispatchQueue.global().async {
            self.getFavorites()
        }
    }
    
}


// MARK: - FavoritesViewInteractorOutputProtocol
extension FavoritesViewPresenter: FavoritesViewInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
