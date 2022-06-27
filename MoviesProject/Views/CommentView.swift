//
//  CommentView.swift
//  MoviesProject
//
//  Created by 23 on 14/6/2565 BE.
//
import URLImage
import Firebase
import SwiftUI
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore


//let testData = [
//    Comment(MId: "3000", commentText: "สนุกมากกก", email: "K@mmm.com", name: "lala",moviename: "madmax"),
//    Comment(MId: "2000", commentText: "Noสนุก", email: "K@XX.com", name: "Kavin",moviename: "madmax"),
//    Comment(MId: "4000", commentText: "Noobb", email: "K@SS.com", name: "Max",moviename: "madmax")
//]


struct CommentView: View {
    

    @ObservedObject private var viewModel = CommentViewModel()
    @State var CMovie: [Comment] = []
    let db = Firestore.firestore()
    var MId : String!
    var movieName : String!
    @State private var showAlert = false
    @State private var showingAlert = false
    @State private var isPresentingConfirm: Bool = false
    
    @State var showUrl = URL(string: "https://img.icons8.com/ios-glyphs/60/undefined/user-male-circle.png")!

    
    @State var commentText: String = ""
    @State var myurl = ""
    
    func fetchImg() async throws -> String {
        //print(Auth.auth().currentUser!.email)
        // Create a reference to the file you want to download
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let starsRef = storageRef.child("\(Auth.auth().currentUser!.email ?? "").jpg")
   
        // Fetch the download URLx
        starsRef.downloadURL { url, error in
          if let error = error {
            // Handle any errors
          } else {
            // Get the download URL for 'images/stars.jpg'
              myurl = url!.absoluteString
            //  return url!.absoluteString
           
              print(url)
            
          }

        }

         return myurl
    }
    
    var body: some View {
        let user = Auth.auth().currentUser
        if let user = user {
            
            let uemail: String = "\(user.email!)"
            let collRef = db.collection("comment").document("AllComments")
                .collection("CommentMovie").order(by: "createdAt")
        }
        
        
        
//        URLImage(showUrl) { image in
//            image
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//        }
        
     
        Text("\(movieName)")
        Spacer()
        
        
        NavigationView{
            List(viewModel.comments){ comm in
                if movieName == comm.moviename{
                                              
                  //  showUrl = URL(string: "\(comm.url == "" ?? "https://img.icons8.com/ios-glyphs/60/undefined/user-male-circle.png":comm.url!)")
                 
                    
               VStack(alignment: .leading){

                   HStack{
                       if comm.url == ""{
                            Image(systemName: "person.circle.fill").resizable().resizable()
                                .foregroundColor(Color.black)
                                .frame(width:25,
                                       height:25).cornerRadius(100)
                       }else{
                           
                           URLImage(URL(string: "\(comm.url)")!) { image in
                           image
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                       } .frame(width: 30, height: 30).cornerRadius(100)
                       }
                        Text(comm.name).font(.headline)
                       if Auth.auth().currentUser!.email == comm.email{
                           Text(" : You").opacity(0.3).font(.system(size: 14))
                       }
                    }
                    HStack{
                        Text(comm.commentText).font(.subheadline)
                        Spacer()
                        if Auth.auth().currentUser!.email == comm.email{
//                            Button {
//                            deleteStore(id: comm.docID)
//                        } label: {
//                            Image(systemName: "trash.fill")
//
//                        }.confirmationDialog("Are you sure?",
//                                             isPresented: $isPresentingConfirm) {
//                                             Button("Delete all items?", role: .destructive) {
//                                                 deleteStore(id: comm.docID)
//                                              }
//                                            }
                            
                            Button( "Delete", role: .destructive) {
                                 isPresentingConfirm = true
                            }.frame(width: 70, height: 25)
                                .font(.system(size: 14))
                              .confirmationDialog("Are you sure?",
                                isPresented: $isPresentingConfirm) {
                                Button("Delete this comment?", role: .destructive) {
                                    deleteStore(id: comm.docID)
                                 }
                               }
                            
                        }
                      
                    }.padding(.all,10).buttonStyle(MybtnStyle())
               }.padding(5)
                }
                
        }
            
        }.navigationBarTitle("Review")
            .onAppear(){
                self.viewModel.fetchData()
            }
        HStack{

            TextField("Enter Comment...", text: $commentText).textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Submit") {
                if(commentText != ""){
                    SubmitClicked()}
                else{
                    showingAlert = true
                }
            }  .alert("Message can't be empty!!!", isPresented: $showingAlert) {
                Button("OK", role: .cancel) {print("alerted") }
            }
            .padding(12)
                .background(Color(UIColor.systemIndigo))
                .foregroundColor(.white)
                .cornerRadius(8)
//                .alert("Message can't be empty!!", isPresented: $showingAlert) {
//                    Button("OK", role: .cancel) { }
        }.padding(.all,10)
        
        
    }
//    private func removeRows(at offsets: IndexSet) {
//            offsets.forEach{ index in
//                let user = Auth.auth().currentUser
//                if let user = user {
//                    let uemail: String = "\(user.email!)"
//                let store = CMovie[index]
//                    db.collection("comment").document("AllComments")
//                        .collection("CommentMovie").whereField("commentText", isEqualTo: store.commentText).getDocuments() {(qs, err) in
//                            if let err = err{
//                                print(err)
//                            }else{
//                                for doc in qs!.documents{
//                                    print(doc.documentID)
//                                    db.collection("comment").document("AllComments")
//                                    .collection("CommentMovie").document(doc.documentID).delete()
//                                    showAlert = true
//                                    self.viewModel.fetchData()
//                                }
//                            }
//                        }
//                }
//            }
//        }
        func deleteStore(id: String){
             print(id)
                 //let user = Auth.auth().currentUser
                 /*if let user = user {
                     let uemail: String = "\(user.email!)"
                     print(uemail)
                     db.collection("comment").document("Allcomments")
                         .collection("CommentMovie").whereField("id", isEqualTo: id).getDocuments() {(qs, err) in
                             if let err = err{
                                 print(err)
                                
                             }else{
                                 for doc in qs!.documents{
                                     print(doc.documentID)
                                     db.collection("comment").document("Allcomments")
                                         .collection("CommentMovie").document(doc.documentID).delete()
                                     
                                 }
                             }
                         }*/
                     db.document("/comment/AllComments/CommentMovie/"+id).delete(){err in
                             if let err = err{
                                 print(err)
                             }else{
                                 print("deleted!")
                                 showAlert = true
                             }
                         }
                   
                     //}
                 }

        func SubmitClicked(){
            
            
                
                let user = Auth.auth().currentUser
                
                if let user = user {
                    
                    let uemail: String = "\(user.email!)"
                    let dpName: String = "\(user.displayName!)"
                    let collRef = db.collection("comment").document("AllComments")
                        .collection("CommentMovie")
                    
                    let storage = Storage.storage()
                    let storageRef = storage.reference()
                    let starsRef = storageRef.child("\(uemail).jpg")
                    var Url: String = ""
                    starsRef.downloadURL { url, error in
                        if let error = error {
                            // Handle any errors
                            print(error)
                        } else {
                            // Get the download URL for 'images/stars.jpg'
                            myurl = url!.absoluteString
                            if myurl != ""{
                                Url = myurl
                                collRef.addDocument(data: ["MId" : MId,
                                                           "email" : uemail,
                                                           "name" : dpName,
                                                           "commentText" : commentText,
                                                           "movieName" : movieName,
                                                           "createdAt" : Timestamp(date: Date()),
                                                           "id" : UUID().uuidString,
                                                           "url" : myurl
                                                          ]
                                                    
                                                    
                                )
                                commentText = ""
                            }
                            print(Url)
                            //      print(url!.absoluteString)
                        }
                    }
                    
                    
                    //            if myurl != ""{
                    //                Url = myurl
                    //            }else{
                    //                let storage = Storage.storage()
                    //                let storageRef = storage.reference()
                    //                let starsRef = storageRef.child("\(uemail).jpg")
                    //                starsRef.downloadURL { url, error in
                    //                          if let error = error {
                    //                            // Handle any errors
                    //                              print(error)
                    //                          } else {
                    //                            // Get the download URL for 'images/stars.jpg'
                    //                              myurl = url!.absoluteString
                    //                        //      print(url!.absoluteString)
                    //                              Url = myurl
                    //                          }
                    //                        }
                    //            }
                             @State   var U:String = myurl
                                print("MYURL = \(myurl)")
                                if myurl != "" {
                                    U = myurl
                                }else{
                                    U = Url
                                }
                    
                    
                    
                }
            
        }

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(MId:String(),movieName: String())
    }
}
    }


struct MybtnStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(5)
            .background(.red)
            .foregroundColor(.white)
            .cornerRadius(10)
//            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
