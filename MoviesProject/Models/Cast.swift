//
//  Cast.swift
//  ProjectMovies
//
//  Created by suranaree09 on 11/5/2565 BE.
//

import Foundation

struct CastResponse: Codable{
    var cast: [Cast]
}

struct Cast: Codable, Identifiable{
    var id: Int?
    var name: String?
    var character: String?
    var profile_path: String?
    var profilePhoto: String {
    if let path = profile_path{
        return "https://image.tmdb.org/t/p/original/\(path)"
    }
        return "https://picsum.photos/200/300"
  }
}
