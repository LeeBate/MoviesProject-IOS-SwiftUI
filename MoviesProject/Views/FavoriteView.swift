//
//  FavoriteView.swift
//  MoviesProject
//
//  Created by suranaree09 on 6/6/2565 BE.
//

import SwiftUI
import Firebase

struct FavoriteView: View {
    @State var FMovie: [Movie] = []
    @State private var showAlert = false
    let db = Firestore.firestore()
    
    
    func GetCarts(){
        FMovie = []
        let user = Auth.auth().currentUser
        if let user = user {
            let uemail: String = "\(user.email!)"
            
            db.collection("user").document(uemail)
                .collection("MyFavoriteMovie").getDocuments(){
                    querySnapshot, err in
                    if let err  = err{
                        print("Error: \(err)")
                    }else{
                        for document in querySnapshot!.documents{
                            let data = document.data()
                            FMovie.append(
                                Movie(
                                    id: data["Id"] as! Int?,
                                    title: data["Title"] as! String?,
                                    original_language: data["Original_language"] as! String?,
                                    overview: data["overview"] as! String?,
                                    poster_path: data["Poster"] as! String?,
                                    backdrop_path: data["backdrop"] as! String?,
                                    popularity: data["popularity"] as? Double,
                                    vote_average: data["vote_average"] as? Double,vote_count: data["vote_count"] as? Int, release_date: data["release"] as! String?
                                )
                            )
                            //print(data["Title"])
                            
                        }
                        print(FMovie)
                    }
                }
        }
    }
    
    private func removeRows(at offsets: IndexSet) {
        offsets.forEach{ index in
            let user = Auth.auth().currentUser
            if let user = user {
                let uemail: String = "\(user.email!)"
                let store = FMovie[index]
                db.collection("user").document(uemail)
                    .collection("MyFavoriteMovie").whereField("Id", isEqualTo: store.id!).getDocuments() {(qs, err) in
                        if let err = err{
                            print(err)
                        }else{
                            for doc in qs!.documents{
                                print(doc.documentID)
                                db.collection("user").document(uemail)
                                    .collection("MyFavoriteMovie").document(doc.documentID).delete()
                                showAlert = true
                                GetCarts()
                            }
                        }
                    }
            }
        }
    }
    
    var body: some View {
        NavigationView{
            List {
                ForEach(FMovie, id: \.id) {movie in
                    NavigationLink(destination: FavoriteDetail(movie: movie)){
                        AsyncImage(url: URL(string: movie.posterPath )!){
                            Rectangle().foregroundColor(Color.gray.opacity(0.4))
                        } image: { (img) -> Image in
                            Image(uiImage: img)
                                .resizable()
                        }
                        .frame(width: 100, height: 160)
                        //.animation(.easeInOut(duration: 0.5))
                        .transition(.opacity)
                        .scaledToFill()
                        .cornerRadius(15)
                        .shadow(radius: 15)
                        
                        VStack(alignment: .leading, spacing: 0){
                            Text(movie.title!)
                                .font(.system(size: 15))
                                .bold()
                                .foregroundColor(.blue)
                            HStack{
                                Text(movie.release_date ?? "")
                                    .foregroundColor(.black)
                                    .font(.subheadline)
                            }
                            Text(movie.overview ?? "")
                                .font(.body)
                                .foregroundColor(Color.gray)
                                .lineLimit(3)
                            
                        }
                    }
                }.onDelete(perform: removeRows).alert(isPresented: $showAlert){
                    Alert(
                        title: Text("Delete Success")
                    )
                }
                //Spacer()
            }
            .toolbar{
                EditButton()
        }

        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        
        .onAppear(perform: GetCarts)
        
    }
}





struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
