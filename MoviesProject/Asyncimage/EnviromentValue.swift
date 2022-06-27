//
//  EnviromentValue+ImageCache.swift
//  ProjectMovies
//
//  Created by suranaree09 on 11/5/2565 BE.
//


import SwiftUI

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TempImageCache()
}

extension EnvironmentValues {
    var imgeCache: ImageCache {
        get{ self[ImageCacheKey.self] }
        set{ self[ImageCacheKey.self] = newValue }
    }
}
