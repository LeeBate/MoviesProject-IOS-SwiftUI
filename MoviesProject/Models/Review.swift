//
//  Review.swift
//  ProjectMovies
//
//  Created by suranaree09 on 11/5/2565 BE.
//

import Foundation


struct ReviewResponse : Codable{
    var results: [Review]
}

struct Review: Codable, Identifiable{
    var id: String?
    var author: String?
    var content: String?
}
