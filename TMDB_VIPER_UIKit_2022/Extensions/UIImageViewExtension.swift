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
    
    /// Retrieve an image, locally or remote if needed
    /// - Warning: it works with the last part of a URL as string ID. Check if it is stored locally or fetch it from the network. The API configuration is needed here, but it is the only one
    /// - Parameters:
    ///   - sufixUrl: string ID to store
    ///   - placeHolderImage: image if no image is retrieved
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
    
    /// Internal function to get an image from local cache
    /// - Parameter urlString: complete URL string
    /// - Returns: UIImage or nil
    private func getImageFromCache(urlString: String) -> UIImage? {
        return ImageCache.shared.retrieveImageFromCache(urlString: urlString)
    }
    
    /// Internal function to get an image from network
    /// - Parameters:
    ///   - urlString: urlString descriptioncomplete URL string
    ///   - success: success handler with UIImage
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
