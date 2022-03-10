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
    static var shared: ImageCacheProtocol { get }
    
    func retrieveImageFromCache(urlString: String) -> UIImage?
    func saveImageToChache(image: UIImage?, urlString: String)
}


// MARK: - ImageCache
class ImageCache: ImageCacheProtocol {
    
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

