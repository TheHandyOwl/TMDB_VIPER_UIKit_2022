//
//  FavoritesCellView.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 13/3/22.
//

import UIKit

class FavoritesCellView: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func cleanCell() {
        movieImage.image = nil
        titleLabel.text = ""
    }
    
    /// Setup cell view with this data
    /// - Parameters:
    ///   - movieTitle: movie title
    ///   - image: string to retrieve an image. UIImage extension used to retrieve the UIImage
    func configureCell(image: String, movieTitle: String) {
        cleanCell()
        
        titleLabel.text = movieTitle
        
        if let placeholderImage = UIImage(systemName: Constants.Views.MovieList.MovieCell.placeholderImage) {
            movieImage.getImage(sufixUrl: image, placeHolderImage: placeholderImage)
        } else {
            movieImage.getImage(sufixUrl: image)
        }
    }
    
}
