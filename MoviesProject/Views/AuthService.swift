//
//  AuthenService.swift
//  MoviesProject
//
//  Created by suranaree09 on 23/5/2565 BE.
//

import Firebase
import SwiftUI
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore
import Combine

struct AuthService: View {
//    static var storeRoot = Firestore.firestore()
//    static var Posts = storeRoot.collection("posts")
//    static var AllPosts = storeRoot.collection("allPosts")
//    static func PstsUserID(userId: String) -> DocumentReference{
//        return Posts.document(userId)
//    }
//
//    static var Timeline = storeRoot.collection("timeline")
//    static func TimelineUserId(userId: String) -> DocumentReference{
//        return Timeline.document(userId)
//    }
    
    
    var body: some View {
       Home()
    }
}

struct Home : View{
    
    @State var show = false
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    var body: some View{
        
        VStack{
            NavigationView{
                if self.status{
                    
                    TabMovies()
                    
                }else{
                    ZStack{
                        NavigationLink(destination: SignUp(show: self.$show),isActive: self.$show){
                            Text("")
                        }
                        .hidden()
                        
                        Login(show: self.$show)
                    }
                }
            }
           
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                .onAppear{
                    NotificationCenter.default.addObserver(forName: NSNotification.Name("status"), object: nil, queue: .main) { (_) in
                        
                        self.status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                    }
                }
            }
            
        }
    }



struct EditProfile: View {
    @State var color = Color.black.opacity(0.7)
    @State var uuEmail = ""
    @State var uuid = ""
    @State var uudpName = ""
    let storage = Storage.storage()
    @State var name = ""
    @State var alert = false
    @State var error = ""
    func Update(){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = self.name
        changeRequest?.commitChanges { err in
            print("-----------------------ERROR!!!!!! = \(err?.localizedDescription)")
            if err?.localizedDescription != nil {
                self.error = "Failed : \(err?.localizedDescription)"
                self.alert.toggle()
            }
         
        }
//        var user = Auth.auth().currentUser
//        if let user = user {
//            var udpName: String = "\(user.displayName!)"
//            self.uudpName = udpName
//
//        }
        
        
    }
    var body: some View {
        ZStack{
        VStack{
            
        
      
            VStack{
        
            TextField("Enter Name",text: self.$name)
                .autocapitalization(.none)
                .padding().background(RoundedRectangle(cornerRadius: 4).stroke(self.name != "" ? Color("Color"): self.color,lineWidth:2))
                .padding(.top,25)
        }
                .cornerRadius(4, antialiased: true)
                .padding(25)
            
            Button(action: {
                if self.name != ""{
                    Update()
                       self.error = "Successful"
                       self.alert.toggle()
                }else{
                    self.error = "Name cannot be empty!"
                    self.alert.toggle()
                }
                
             
            }){
                Text("Save")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
            }
            .background(Color("Color"))
            .cornerRadius(4, antialiased: true)
            .padding(.top,25)
            .onAppear(){
                var user = Auth.auth().currentUser
                if let user = user {
                    var uid: String = "\(user.uid)"
                    var uemail: String = "\(user.email!)"
                    var udpName: String = "\(user.displayName)"
                    
                    
                    self.uuEmail = uemail
                    self.uuid = uid
                    self.uudpName = udpName
                }
                
        }
         
            
        Spacer()
        }
            
            if self.alert{
                ErrorView(alert: self.$alert, error: self.$error)}
        }
      
    }
}
struct Homescreen : View {
    
    @State var uuEmail = ""
    @State var uuid = ""
    @State var uudpName:String = ""
    let storage = Storage.storage()
    @State var name = ""
    @State var alert = false
    @State var error = ""
    
  
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    private let objectWillChange = ObservableObjectPublisher()
    
    
    
    var body: some View{
        
        NavigationView{
        
            VStack(){
            VStack(alignment: .center, spacing: 10){
                if selectedImage != nil{
                    ZStack{
                    Image(uiImage: selectedImage!).resizable().resizable()
                        .foregroundColor(Color.blue)
                        .frame(width:200,
                               height:200).cornerRadius(100)
                        

                        
                        Button( action:{
                            self.sourceType = .photoLibrary
                            self.isImagePickerDisplay.toggle()
                            
                        }){
                            ZStack{
                                Image(systemName: "circle.fill").resizable().resizable()
                                    .foregroundColor(Color.black)
                                    .frame(width:40,
                                           height:40).padding(.leading, 138).padding(.top, 138)
                                    .shadow(color: .black, radius: 3)

                        Image(systemName: "plus.circle.fill").resizable().resizable()
                            .foregroundColor(Color.white)
                            .frame(width:40,
                                   height:40).padding(.leading, 138).padding(.top, 138)

                            }
                        }
                    }
                }else{
//                Image(systemName: "person.fill").resizable().resizable()
//                    .foregroundColor(Color.blue)
//                    .frame(width:150.0,
//                           height:150.0)
//                    Image(systemName: "plus.circle").resizable().resizable()
//                        .foregroundColor(Color.blue)
//                        .frame(width:20,
//                               height:20)
                    ZStack{
                    Image(systemName: "person.circle.fill").resizable().resizable()
                        .foregroundColor(Color.black)
                        .frame(width:200,
                               height:200).cornerRadius(100)
                        

                        
                        Button( action:{
                            self.sourceType = .photoLibrary
                            self.isImagePickerDisplay.toggle()
                            
                        }){
                            ZStack{
                                Image(systemName: "circle.fill").resizable().resizable()
                                    .foregroundColor(Color.black)
                                    .frame(width:40,
                                           height:40).padding(.leading, 138).padding(.top, 138)
                                    .shadow(color: .black, radius: 3)

                        Image(systemName: "plus.circle.fill").resizable().resizable()
                            .foregroundColor(Color.white)
                            .frame(width:40,
                                   height:40).padding(.leading, 138).padding(.top, 138)

                            }
                        }
                    }
                }
             
               
                    Text("\(uudpName )").font(.system(size: 25)).fontWeight(.bold).onAppear(perform: updateView)
                  
                    Text(" \(uuEmail)").font(.system(size: 20))
                    Button(action: {
                        print("Floating Button Click")
                    }, label: {
                        NavigationLink(destination: EditProfile()) {
                            Text("Edit Name")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                         }
                        .background(Color("Color"))
                            .cornerRadius(4, antialiased: true)
                            .padding(.top,25)
                    })
                   
            
               

                Button( action:{ try! Auth.auth().signOut()
                    UserDefaults.standard.set(false, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                    
                }){
                    Text("Sign out")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 50)
                } .background(Color.red)
                    .cornerRadius(4, antialiased: true)
                    .padding(.top,1)
            }
           
            .onAppear(){
                var user = Auth.auth().currentUser
                   if let user = user {
                       var uid: String = "\(user.uid)"
                       var uemail: String = "\(user.email!)"
                       if user.displayName != nil{
                           
                       
                       let udpName: String = "\(user.displayName!)"
                           self.uudpName = udpName
                       }
                       
                       self.uuEmail = uemail
                       self.uuid = uid
                   }
            }.onAppear(perform:loadImage)
                .sheet(isPresented: self.$isImagePickerDisplay, onDismiss: UploadImage) { ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
            }
                Spacer()
            }.padding(.bottom,250)
        }.navigationBarBackButtonHidden(true).navigationBarHidden(true)
            
            .onAppear(){
          //  objectWillChange.send()
            var user = Auth.auth().currentUser
               if let user = user {
                   var uemail: String = "\(user.email!)"
                   let udpName: String = "\(user.displayName)"
                       self.uudpName = udpName
                       self.uuEmail = uemail
                  // objectWillChange.send()
               }
        }
    }

    func updateView(){
      
        
      }
    func UploadImage(){
        let storageRef = storage.reference().child("\(uuEmail).jpg")
        let data = selectedImage?.jpegData(compressionQuality: 0.2)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        if let data = data{
            storageRef.putData(data, metadata: metadata){
                metadata,error in
                if let error = error{
                    print("Error: \(error)")
                }
                if metadata != nil{
                    print("Done")
                }
            }
        }
    }
    
    func loadImage(){
        let storageRef = storage.reference().child("\(uuEmail).jpg")
        storageRef.getData(maxSize: 1*1024*1024) { data, error in if let error = error {
            print("เออเรอออออออออออออออออ \(error)")
            
            
        }
           
            else {
                selectedImage = UIImage(data: data!) }
        } }
    
}


struct Login : View {
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var pass = ""
    @State var visible = false
    @Binding var show : Bool
    @State var alert = false
    @State var error = ""
    
    var body: some View{
        ZStack{
            ZStack(alignment: .topLeading){
                
                GeometryReader{_ in
                    VStack{
                        Image("logo").resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 250, alignment: .center).padding(.top,-70)
                        Text("Log in to your account")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(self.color)
                            .padding(.top,0)
                        
                        TextField("Email",text: self.$email)
                            .autocapitalization(.none)
                            .padding().background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Color"): self.color,lineWidth:2))
                            .padding(.top,25)
                        
                        VStack{
                            HStack(spacing:15){
                                if self.visible{
                                    TextField("Password",text: self.$pass)
                                        .autocapitalization(.none)
                                }else
                                {
                                    SecureField("Password",text: self.$pass)
                                        .autocapitalization(.none)
                                    
                                    
                                }
                                Button(action: {
                                    self.visible.toggle()
                                }){
                                    Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(self.color)
                                }
                            }
                            .padding().background(RoundedRectangle(cornerRadius: 4).stroke(self.pass != "" ? Color("Color"): self.color,lineWidth:2))
                            .padding(.top,25)
                            
                            
                            HStack{
                                Spacer()
                                
                                Button(action: {
                                    self.reset()
                                    
                                }){
                                    Text("Forget Password")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("Color"))
                                }
                            }.padding(.top,25)
                            
                            
                            Button(action: {
                                self.verify()
                            }){
                                Text("Sign in")
                                    .foregroundColor(.white)
                                    .padding(.vertical)
                                    .frame(width: UIScreen.main.bounds.width - 50)
                            }
                            .background(Color("Color"))
                            .cornerRadius(4, antialiased: true)
                            .padding(.top,25)
                            
                        }
                        HStack{
                            Text("Not Registered?")
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(self.color)
                            Button(action: {
                                self.show.toggle()
                            }){
                                
                                
                                
                                
                                Text("Register")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("Color"))
                                
                            }
                        }
                        .padding(25).padding(.bottom,35)
                    }
                    .padding(.horizontal,25).padding(.vertical,-20)
                    
                }
                
            }
            
            if self.alert{
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
    }
    func verify(){
        if self.email != "" && self.pass != "" {
            Auth.auth().signIn(withEmail: self.email, password: self.pass ){
                (res,err) in
                
                if err != nil{
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                print("success")
                UserDefaults.standard.set(true,forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
            }
        }else{
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
        }
    }
    
    func reset(){
        if self.email != ""{
            Auth.auth().sendPasswordReset(withEmail: self.email){
                (err) in
                
                if err != nil{
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                    
                }
                self.error = "RESET"
                self.alert.toggle()
            }
            
        }
        else{
            self.error = "Email Id is empty"
            self.alert.toggle()
        }
    }
}

struct SignUp : View {
    @State var color = Color.black.opacity(0.7)
    @State var name = ""
    @State var email = ""
    @State var pass = ""
    @State var repass = ""
    @State var visible = false
    @State var revisible = false
    @Binding var show : Bool
    @State var alert = false
    @State var error = ""
    
    
    var body: some View{
        ZStack{
            ZStack(alignment: .topLeading){
                
                GeometryReader{_ in
                    VStack{
                        Image("logo").resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 250, alignment: .center)
                        Text("Register new account")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(self.color)
                            .padding(0)
                        
                        
                        
                        VStack{
                            
                            TextField("Username",text: self.$name)
                                .autocapitalization(.none)
                                .padding().background(RoundedRectangle(cornerRadius: 4).stroke(self.name != "" ? Color("Color"): self.color,lineWidth:2))
                                .padding(.top,25)
                            
                            TextField("Email",text: self.$email)
                                .autocapitalization(.none)
                                .padding().background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Color"): self.color,lineWidth:2))
                                .padding(.top,25)
                            
                            HStack(spacing:15){
                                if self.visible{
                                    TextField("Password",text: self.$pass)
                                        .autocapitalization(.none)
                                }else
                                {
                                    SecureField("Password",text: self.$pass)
                                        .autocapitalization(.none)
                                    
                                }
                                Button(action: {
                                    self.visible.toggle()
                                }){
                                    Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(self.color)
                                }
                            }
                            .padding().background(RoundedRectangle(cornerRadius: 4).stroke(self.pass != "" ? Color("Color"): self.color,lineWidth:2))
                            .padding(.top,25)
                            
                            
                            VStack{
                                HStack(spacing:15){
                                    if self.revisible{
                                        TextField("Re-Password",text: self.$repass)
                                            .autocapitalization(.none)
                                    }else
                                    {
                                        SecureField("Re-Password",text: self.$repass)
                                            .autocapitalization(.none)
                                        
                                        
                                    }
                                    Button(action: {
                                        self.revisible.toggle()
                                    }){
                                        Image(systemName: self.revisible ? "eye.slash.fill" : "eye.fill")
                                            .foregroundColor(self.color)
                                    }
                                }
                                .padding().background(RoundedRectangle(cornerRadius: 4).stroke(self.repass != "" ? Color("Color"): self.color,lineWidth:2))
                                .padding(.top,25)
                                
                                
                                
                                Button(action: {
                                    self.register()
                                }){
                                    Text("Register")
                                        .foregroundColor(.white)
                                        .padding(.vertical)
                                        .frame(width: UIScreen.main.bounds.width - 50)
                                }
                                .background(Color("Color"))
                                .cornerRadius(4, antialiased: true)
                                .padding(.top,25)
                                
                                
                                
                            }
                        }
                        .padding(.horizontal,25)
                        
                    }
                    
                }
                
                HStack{
                    
                    Button(action: {
                        self.show.toggle()
                    }){
                        
                        
                        
                        
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .foregroundColor(Color("Color"))
                        
                    }
                }
                .padding()
                
            }
            
            if self.alert{
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
      //  .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    func register(){
        
        if self.email  != "" && self.name != "" {
            if self.pass == self.repass{
                Auth.auth().createUser(withEmail: self.email, password: self.pass){
                    (res, err) in
                    
                    if err != nil{
                        self.error = err!.localizedDescription
                        self.alert.toggle()
                        return
                    }else{
                        self.error = "Successful Create!"
                        self.alert.toggle()
                       
                        
                    }
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = self.name
                    changeRequest?.commitChanges { error in
                        print(error?.localizedDescription)}
                    
                 
                    print("success regiser")
                    UserDefaults.standard.set(true, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                    
                }
                
            }else{
                self.error = "Password mismatch"
                self.alert.toggle()
            }
        }else{
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
        }
        
    }
}

struct ErrorView : View {
    
    @State var color = Color.black.opacity(0.7)
    @Binding var alert : Bool
    @Binding var error : String
    
    var body: some View{
        
        GeometryReader{_ in
            
            VStack{
                VStack{
                    HStack{
                        if self.error != "Successful"{
                        Text(self.error == "RESET"  ? "Message" : "Error")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(self.color)
                       
                        Spacer()
                        }else{
                            Text("Successful")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(self.color)
                        }
                    }
                    .padding(.horizontal,25).padding(.vertical,10)
                    if self.error != "Successful"{
                        
                    Text(self.error == "RESET" ? "Password reset link has been sent successfully" : self.error)
                        .foregroundColor(self.color)
                        .padding(.top)
                        .padding(.horizontal,25)
                        
                    Button(action: {
                        self.alert.toggle()
                        
                    }){
                        Text(self.error == "RESET" ? "OK" : "Cancel")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 120)
                    }
                    .background(Color("Color"))
                    .cornerRadius(10, antialiased: true)
                    .padding(.top,25).padding(.all,20)
                    }else{
                        Text("Your Name Successfully changed!")
                            .foregroundColor(self.color)
                            .padding(.top)
                            .padding(.horizontal,25)
                            
                        Button(action: {
                            self.alert.toggle()
                            
                        }){

                                Text("OK")
                                    .foregroundColor(.white)
                                    .padding(.vertical)
                                    .frame(width: UIScreen.main.bounds.width - 120)
                        }
                        .background(Color("Color"))
                        .cornerRadius(10, antialiased: true)
                        .padding(.top,25).padding(.all,20)
                    }
                    
                }
                
                .frame(width: UIScreen.main.bounds.width - 70)
                .background(Color.white)
                .cornerRadius(5, antialiased: true).padding(.horizontal,30).padding(.vertical,200)
            }
            
            
        }
        .background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
        
    }
}

struct AlertView : View {
    
    @State var color = Color.black.opacity(0.7)
    @Binding var alert : Bool
    @Binding var error : String
    
    var body: some View{
        
        GeometryReader{_ in
            
            VStack{
                VStack{
                    HStack{
                        Text(self.error == "Confirmation"  ? "Confirmation" : "Confirmation")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(self.color)
                        
                        Spacer()
                    }
                    .padding(.horizontal,25).padding(.vertical,10)
                    
                    Text(self.error == "Confirmation" ? "Are you sure to log out?" : self.error)
                        .foregroundColor(self.color)
                        .padding(.top)
                        .padding(.horizontal,25)
                    Button(action: {
                        self.alert.toggle()
                        
                    }){
                        Text(self.error == "RESET" ? "OK" : "OK")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 120)
                    }
                    .background(Color("Color"))
                    .cornerRadius(10, antialiased: true)
                    .padding(.top,25).padding(.all,20)
                    
                }
                
                .frame(width: UIScreen.main.bounds.width - 70)
                .background(Color.white)
                .cornerRadius(5, antialiased: true).padding(.horizontal,30).padding(.vertical,200)
            }
            
            
        }
        .background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
        
    }
}





struct AuthService_Previews: PreviewProvider {
    static var previews: some View {
        AuthService()
    }
}
