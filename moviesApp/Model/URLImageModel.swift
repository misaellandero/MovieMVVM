//
//  URLImageModel.swift
//  moviesApp
//
//  Created by Francisco Misael Landero Ychante on 12/10/20.
//

import Foundation
import SwiftUI

class UrlImageModel: ObservableObject {
    @Published var image : UIImage?
    var urlString : String?
    var imageCache = ImageCache.getImageCache()

    init(imageName : String?) {
        
        self.urlString = "https://image.tmdb.org/t/p/w500\(imageName ?? "none")"
        loadImage()
    }
    
    
    func loadImage() {
        if loadImageFromCache() {
            return
        }
        
        loadImageFromURL()
    }
    
    
    func loadImageFromCache() -> Bool {
        guard  let urlString = urlString else {
             return false
        }
        
        guard let cacheImage = imageCache.get(forKey: urlString) else {
            return false
        }
        
        image = cacheImage
        return true
         
    }
    
    func loadImageFromURL() {
        
        
          
        let url = URL(string: urlString ?? "none")
        
        guard url != nil else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url!, completionHandler: parseImageFromResponse(data:response:error:))
        task.resume()
    }
    
    func parseImageFromResponse(data: Data?, response: URLResponse?, error: Error?) {
        
        guard error == nil else {
            print("error: \(error!)")
            return
        }
        
        guard let data = data else {
            print("no data found")
            return
        }
        
        DispatchQueue.main.async {
            guard let loadedImage = UIImage(data: data) else {
                return
            }
            self.imageCache.set(forKey: self.urlString!, image: loadedImage)
            self.image = loadedImage
            
        }
        
        
    }
    
    
}

class ImageCache {
    
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension ImageCache {
    private static var imageCache = ImageCache()
    static func getImageCache() -> ImageCache {
        return imageCache
    }
}
