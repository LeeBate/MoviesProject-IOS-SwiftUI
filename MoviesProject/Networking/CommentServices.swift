//
//  CommentServiecs.swift
//  MoviesProject
//
//  Created by suranaree09 on 2/6/2565 BE.
//
//
//import Foundation
//import Firebase
//
//class CommentServices: ObservableObject{
//    
//    static var commentsRef = AuthService.storeRoot.collection("comment")
//    
//    static func commentsId(postId: String) -> DocumentReference{
//        return commentsRef.document(postId)
//    }
//    
//    func postComment(comment: String, username: String, profile: String, ownerId: String, postId: String, onSuccess: @escaping()-> Void, onError: @escaping(_ error: String) -> Void){
//        
//        let comment = CommentModel(profile: profile, postId: postId, username: username, data: Date().timeIntervalSince1970, comment: comment, ownerId: ownerId)
//        
//        guard let dict = try? comment.asDictionary() else {
//            return
//        }
//        
//        CommentServices.commentsId(postId: postId).collection("comments").addDocument(data: dict){
//            (err) in
//            
//            if let err = err{
//                onError(err.localizedDescription)
//            }
//            onSuccess()
//        }
//    }
//}
