//
//  MovieURL.swift
//  MoviesProject
//
//  Created by suranaree09 on 19/5/2565 BE.
//

import Foundation

enum MovieURL: String{
    case nowPlaying = "now_playing"
    case upcoming = "upcoming"
    case popular = "popular"
    
    public var urlString: String {
        "\(MovieManagerLoad.baseURL)\(self.rawValue)?api_key=\(API.key)&language=en-US&page=1"
    }
}
