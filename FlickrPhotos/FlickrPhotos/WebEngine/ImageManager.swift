//
//  DownloadManager.swift
//  FlickrPhotos
//
//  Created by Srinivas Gadda on 11/05/24.
//

import Foundation
import UIKit

struct ImageManager {
    
    func fetchImage(url: URL) async -> UIImage? {
        let fileNameStr: String = url.lastPathComponent
        
        guard let image = MemoryCache().retrieveImage(fileName: fileNameStr) else {
            do {
                let (imageData, _) = try await URLSession.shared.data(from: url)
                guard let img = UIImage(data: imageData) else {
                    return nil
                }
                MemoryCache().saveImage(image: img, fileName: fileNameStr)
                return img
            } catch {
                return nil
            }
        }
        return image
    }
}
