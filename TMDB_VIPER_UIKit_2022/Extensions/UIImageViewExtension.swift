//
//  UIImageViewExtension.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 10/3/22.
//

import Foundation
import UIKit


// MARK: - UIImageView
extension UIImageView {
    
    func getImage(sufixUrl: String, placeHolderImage: UIImage? = nil) {
        
        let urlString = "\(Constants.API.URL.urlMainImagesW200)\(sufixUrl)"
        
        if let image = getImageFromCache(urlString: urlString) {
            self.image = image
            return
        }
        
        if self.image == nil, let placeHolderImage = placeHolderImage {
            self.image = placeHolderImage
        }
        
        getImageFromNetwork(urlString: urlString) { [weak self] image in
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
    
    private func getImageFromCache(urlString: String) -> UIImage? {
        return ImageCache.shared.retrieveImageFromCache(urlString: urlString)
    }
    
    private func getImageFromNetwork(urlString: String, success: @escaping((UIImage) -> ())) {
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        
        ConnectionManager.shared.getJustAnImage(urlRequest: urlRequest) { imageData in
            guard let finalImage = UIImage(data: imageData) else { return }
            ImageCache.shared.saveImageToChache(image: finalImage, urlString: urlString)
            success(finalImage)
        }
    }
    
}
