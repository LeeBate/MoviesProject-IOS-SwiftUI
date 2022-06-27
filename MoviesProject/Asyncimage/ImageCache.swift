//
//  ImageCache.swift
//  ProjectMovies
//
//  Created by suranaree09 on 11/5/2565 BE.
//

import UIKit

protocol ImageCache {
    subscript(url: URL) -> UIImage? {get set}
}

struct TempImageCache: ImageCache {
    private let cache: NSCache<NSURL, UIImage> = {
        let cache = NSCache<NSURL, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()
    subscript(url: URL) -> UIImage? {
        get{
            cache.object(forKey: url as NSURL)
        }
        set{
            newValue == nil ? cache.removeObject(forKey: url as NSURL) : cache.setObject(newValue!, forKey: url as NSURL)
        }
    }
}
    
