//
//  MovieListCellView.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 10/3/22.
//

import UIKit


// MARK: - MovieListCellView
class MovieListCellView: UITableViewCell {

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
        movieImage.image = UIImage(systemName: Constants.Views.MovieList.MovieCell.placeholderImage)
        titleLabel.text = ""
        synopsisLabel.text = ""
    }
    
    func configureCell(movieTitle: String, movieSinopsis: String) {
        movieImage.image = UIImage(systemName: Constants.Views.MovieList.MovieCell.placeholderImage)
        titleLabel.text = movieTitle
        synopsisLabel.text = movieSinopsis
    }
    
}
