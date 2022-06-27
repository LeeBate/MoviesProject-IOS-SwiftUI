//
//  CommentModel.swift
//  MoviesProject
//
//  Created by suranaree09 on 2/6/2565 BE.
//

import Foundation

struct CommentModel: Encodable, Decodable{
    
        var like: [String: Bool]
        var likeCount: Int
        var dislike: [String: Bool]
        var dislikeCount: Int
}
