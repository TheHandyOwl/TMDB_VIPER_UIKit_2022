//
//  MovieListPresenter.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 10/3/22.
//  
//

import Foundation


// MARK: - protocol MovieListPresenterProtocol
protocol MovieListPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: MovieListViewProtocol? { get set }
    var interactor: MovieListInteractorInputProtocol? { get set }
    var wireFrame: MovieListWireFrameProtocol? { get set }
    
    func viewDidLoad()
}


// MARK: - MovieListPresenter
class MovieListPresenter  {
    
    // MARK: Properties
    weak var view: MovieListViewProtocol?
    var interactor: MovieListInteractorInputProtocol?
    var wireFrame: MovieListWireFrameProtocol?

    private func getMovies() {
        view?.startActivity()
        
        DispatchQueue.global().async {
            self.interactor?.getPopularMovies(success: { movies in
                self.view?.refreshList(movies: movies)
                self.view?.stopActivity()
            }, failure: { networkError in
                print("\(Constants.Strings.errorLiteral): \(networkError)")
            })
        }
    }
    
}


// MARK: - MovieListPresenterProtocol
extension MovieListPresenter: MovieListPresenterProtocol {
    
    func viewDidLoad() {
        let viewTitle = Constants.Views.MovieList.title
        view?.setupUI(viewTitle: viewTitle)
        
        getMovies()
    }
        
}


// MARK: - MovieListInteractorOutputProtocol
extension MovieListPresenter: MovieListInteractorOutputProtocol {
}
