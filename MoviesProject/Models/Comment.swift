//
//  Comment.swift
//  MoviesProject
//
//  Created by 23 on 14/6/2565 BE.
//

import Foundation


struct Comment: Identifiable{
    var id: String = UUID().uuidString
    var MId: String
    var commentText : String
    var email: String
    var name: String
    var moviename: String
    var url: String = ""
    var docID: String = ""

        
}
