//
//  MovieListCellView.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 10/3/22.
//

import UIKit

// MARK: - MovieListCellView
final class MovieListCellView: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleTagLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisTagLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func cleanCell() {
        movieImage.image = nil
        titleLabel.text = ""
        synopsisLabel.text = ""
    }
    
    /// Setup cell view with this data
    /// - Parameters:
    ///   - movieTitle: movie title
    ///   - movieSynopsis: movie synopsis
    ///   - image: string to retrieve an image. UIImage extension used to retrieve the UIImage
    func configureCell(movieTitle: String, movieSynopsis: String, image: String) {
        cleanCell()
        
        titleLabel.text = movieTitle
        synopsisLabel.text = movieSynopsis
        
        if let placeholderImage = UIImage(systemName: Constants.Views.MovieList.MovieCell.placeholderImage) {
            movieImage.getImage(sufixUrl: image, placeHolderImage: placeholderImage)
        } else {
            movieImage.getImage(sufixUrl: image)
        }
    }
    
}
