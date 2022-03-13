//
//  MovieDetailView.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 11/3/22.
//  
//

import Foundation
import UIKit


// MARK: - protocol MovieDetailViewProtocol
protocol MovieDetailViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: MovieDetailPresenterProtocol? { get set }
    
    func setupMovie(movieDetail: MovieDetail)
    func setupUI(withTitle: String)
    func startActivity()
    func stopActivity()
}


// MARK: - MovieDetailView
final class MovieDetailView: UIViewController {
    
    
    // MARK: Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var movieDetailTitleLabel: UILabel!
    @IBOutlet weak var movieDetailImage: UIImageView!
    @IBOutlet weak var originalTitleContentLabel: UILabel!
    @IBOutlet weak var originalTitleLiteralLabel: UILabel!
    @IBOutlet weak var ratingContentLabel: UILabel!
    @IBOutlet weak var ratingLiteralLabel: UILabel!
    @IBOutlet weak var releaseDateContentLabel: UILabel!
    @IBOutlet weak var releaseDateLiteralLabel: UILabel!
    @IBOutlet weak var synopsisContentLabel: UILabel!
    @IBOutlet weak var synopsisLiteralLabel: UILabel!
    

    // MARK: Properties
    var presenter: MovieDetailPresenterProtocol?
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewWillAppear()
    }
    
    
    private func cleanUI() {
        self.movieDetailImage.image = nil
        self.movieDetailTitleLabel.text = ""
        self.originalTitleContentLabel.text = ""
        self.ratingContentLabel.text = ""
        self.releaseDateContentLabel.text = ""
        self.synopsisContentLabel.text = ""
    }
    
    @objc func switchValueDidChange(sender: UISwitch!) {
        guard let switchValue = sender?.isOn else { return }
        presenter?.addOrRemoveFavorite(state: switchValue)
    }
    
    private func setupFavoriteBarButton(defaultValue: Bool) {
        let barButtonItem = ButtonFactory.shared.createToggleUIBarButtonItem(defaultValue: defaultValue, tintColor: .systemGreen, target: self, action: #selector(switchValueDidChange(sender:)))
        
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
}


// MARK: - MovieDetailViewProtocol
extension MovieDetailView: MovieDetailViewProtocol {
    
    func setupMovie(movieDetail: MovieDetail) {
        DispatchQueue.main.async {
            if let placeholderImage = UIImage(systemName: Constants.Views.MovieDetail.placeholderImage) {
                self.movieDetailImage.getImage(sufixUrl: movieDetail.image, placeHolderImage: placeholderImage)
            }
            self.movieDetailTitleLabel.text = movieDetail.title
            self.originalTitleContentLabel.text = movieDetail.originalTitle
            self.ratingContentLabel.text = movieDetail.rating
            self.releaseDateContentLabel.text = movieDetail.releaseDate
            self.synopsisContentLabel.text = movieDetail.synopsis
            self.setupFavoriteBarButton(defaultValue: movieDetail.favorite)
        }
    }
    
    func setupUI(withTitle: String) {
        DispatchQueue.main.async {
            self.movieDetailTitleLabel.text = withTitle
            self.cleanUI()
        }
    }
    
    func startActivity() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
    }
    
    func stopActivity() {
        DispatchQueue.main.async {
            self.activityIndicator.hidesWhenStopped = true
            self.activityIndicator.stopAnimating()
        }
    }
    
}
