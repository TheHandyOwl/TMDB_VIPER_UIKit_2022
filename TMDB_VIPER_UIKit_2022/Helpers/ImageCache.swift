//
//  ImageCache.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 10/3/22.
//

import Foundation
import UIKit


// MARK: - ImageCacheProtocol
protocol ImageCacheProtocol: AnyObject {
    
    /// Singleton pattern
    static var shared: ImageCacheProtocol { get }
    
    /// Retrieve an image locally, stored in `Dictionary<String, UIImage>`
    /// - Parameters:
    ///   - urlString: string ID to retrieve the image
    /// - Returns: UIImage or nil
    func retrieveImageFromCache(urlString: String) -> UIImage?
    
    /// Store an image locally, in `Dictionary<String, UIImage>`
    /// - Parameters:
    ///   - image: string ID to save
    ///   - urlString: string ID to save the image
    func saveImageToChache(image: UIImage?, urlString: String)
}


// MARK: - ImageCache
final class ImageCache: ImageCacheProtocol {
    
    static var shared: ImageCacheProtocol = ImageCache()
    
    private var cacheDictionary = Dictionary<String, UIImage>()
    
    func retrieveImageFromCache(urlString: String) -> UIImage? {
        let url = NSURL(fileURLWithPath: urlString)
        return cacheDictionary[url.absoluteString!]
    }
    
    func saveImageToChache(image: UIImage?, urlString: String) {
        let url = NSURL(fileURLWithPath: urlString)
        if let image = image {
            cacheDictionary[url.absoluteString!] = image
        }
    }
    
}

