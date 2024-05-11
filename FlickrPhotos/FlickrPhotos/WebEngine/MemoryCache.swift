//
//  MemoryCache.swift
//  FlickrPhotos
//
//  Created by Srinivas Gadda on 11/05/24.
//

import Foundation
import UIKit

protocol SaveProtocol {
    func saveImage(image: UIImage, fileName: String)
}

protocol RetrieveProtocol {
    func retrieveImage(fileName: String) -> UIImage?
}

//Composite protocol
protocol CacheProtocol: SaveProtocol, RetrieveProtocol {
    
}

class MemoryCache: CacheProtocol {
    let cache = NSCache<AnyObject, AnyObject>()
    
    func saveImage(image: UIImage, fileName: String) {
        cache.setObject(image, forKey: fileName as AnyObject)
    }
    
    func retrieveImage(fileName: String) -> UIImage? {
        return cache.object(forKey: fileName as AnyObject) as? UIImage
    }
}
