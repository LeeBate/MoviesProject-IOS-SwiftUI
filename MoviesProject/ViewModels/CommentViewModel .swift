//
//  CommentViewModel .swift
//  MoviesProject
//
//  Created by 23 on 14/6/2565 BE.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import Firebase


class CommentViewModel :ObservableObject{
    @Published var comments = [Comment]()
     var myurl = ""
    private var db = Firestore.firestore()
    
    func fetchData(){
        db.collection("comment").document("AllComments")
            .collection("CommentMovie").order(by: "createdAt").addSnapshotListener{ [self] (QuerySnapshot,error) in
                guard let documents = QuerySnapshot?.documents else{
                    return
                }
                self.comments =    documents.map { (queryDocumentSnapshot) -> Comment in
                    let data = queryDocumentSnapshot.data()

                    let docID = queryDocumentSnapshot.documentID
                    let MId = data["MId"] as? String ?? ""
                    let commentText = data["commentText"]as? String ?? ""
                    let email = data["email"]as? String ?? ""
                    let name = data["name"]as? String ?? ""
                    let movieName = data["movieName"]as? String ?? ""
                   let  id = data["id"]as? String ?? ""
                    let storage = Storage.storage()
                    let storageRef = storage.reference()
                    let starsRef = storageRef.child("\(email).jpg")
                    
                    starsRef.downloadURL { url, error in
                              if let error = error {
                                // Handle any errors
                                  print(error)
                              } else {
                                // Get the download URL for 'images/stars.jpg'
                                  myurl = url!.absoluteString
                            //      print(url!.absoluteString)
                              }
                            }
               
                    let url =  data["url"]as? String ?? ""
                //    print(myurl)

                    return Comment(id:id, MId: MId, commentText: commentText, email: email, name: name, moviename: movieName,url:url, docID: docID)
                }
                    
            }
    }
    
//
//    func fectImg(email: String) async throws -> String{
//        var myurl = ""
//        // Create a reference to the file you want to download
//        let storage = Storage.storage()
//        let storageRef = storage.reference()
//        let starsRef = storageRef.child("\(email).jpg")
//print("Fets")
//        // Fetch the download URL
//        starsRef.downloadURL { url, error in
//          if let error = error {
//            // Handle any errors
//              print(error)
//          } else {
//            // Get the download URL for 'images/stars.jpg'
//              myurl = url!.absoluteString
//              print(url!.absoluteString)
//          }
//        }
//        print(myurl)
//        return  myurl
//                }
    
    
    func fetchImg() -> String  {
        //print(Auth.auth().currentUser!.email)
        // Create a reference to the file you want to download
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let starsRef = storageRef.child("\(Auth.auth().currentUser!.email ?? "").jpg")
   
        // Fetch the download URL
        starsRef.downloadURL {  url, error in
          if let error = error {
            // Handle any errors
          } else {
            // Get the download URL for 'images/stars.jpg'
              self.myurl = url!.absoluteString
            //  return url!.absoluteString
           
            //  print(url)
            
          }

        }

        return myurl
    }
    
}
