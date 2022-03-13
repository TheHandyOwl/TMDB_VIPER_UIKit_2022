//
//  MovieDetailPresenter.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 11/3/22.
//  
//

import Foundation


// MARK: - protocol MovieDetailPresenterProtocol
protocol MovieDetailPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: MovieDetailViewProtocol? { get set }
    var interactor: MovieDetailInteractorInputProtocol? { get set }
    var wireFrame: MovieDetailWireFrameProtocol? { get set }
    
    var movieID: Int? { get set }
    
    func viewDidLoad()
}


// MARK: - protocol MovieDetailInteractorOutputProtocol
protocol MovieDetailInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}

// MARK: - MovieDetailPresenter
final class MovieDetailPresenter  {
    
    // MARK: Properties
    weak var view: MovieDetailViewProtocol?
    var interactor: MovieDetailInteractorInputProtocol?
    var wireFrame: MovieDetailWireFrameProtocol?
    
    var movieID: Int?
    
    private func getMovieDetail(movieID: Int) {
        view?.startActivity()
        interactor?.getMovie(movieID: movieID, success: { [weak self] movieDetail in
            self?.view?.setupMovie(movieDetail: movieDetail)
            self?.view?.stopActivity()
        }, failure: { [weak self] networkError in
            self?.view?.stopActivity()
            print("\(Constants.Strings.errorLiteral): \(networkError.localizedDescription)")
        })
    }

}


// MARK: - MovieDetailPresenterProtocol
extension MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    // TODO: implement presenter methods
    func viewDidLoad() {
        view?.setupUI(withTitle: Constants.Views.MovieDetail.title)
        guard let movieID = movieID else { return }
        
        getMovieDetail(movieID: movieID)
    }
    
}


// MARK: - MovieDetailInteractorOutputProtocol
extension MovieDetailPresenter: MovieDetailInteractorOutputProtocol {
}
