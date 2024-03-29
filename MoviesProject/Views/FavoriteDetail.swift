//
//  FavoriteDetail.swift
//  MoviesProject
//
//  Created by suranaree09 on 9/6/2565 BE.
//
import SwiftUI
import Firebase

struct FavoriteDetail: View {
    @StateObject private var loader: ImageLoader
    @ObservedObject private var movieManager = MovieManagerLoad()
    let db = Firestore.firestore()
    
    var movie: Movie

    init(movie: Movie){
    self.movie = movie
        _loader = StateObject(wrappedValue: ImageLoader(url: URL(string: movie.posterPath)!, cache: Environment(\.imgeCache).wrappedValue))
    }
    
    var body: some View {
        ZStack(alignment: .top){
            backgroundView
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading){
                    headerView
                    moviePosterView
                    movieOverView
                    reviewLink
                    castInfo
                    Spacer()
                }.padding(.top, 84)
                .padding(.horizontal, 32)
            }
        }.edgesIgnoringSafeArea(.all)

    }

    private var backgroundView: some View {
        imageView.onAppear(){
            loader.load()
        }
        .blur(radius: 100)
    }
    
    private var imageView: some View {
        Group{
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()
            }else {
                Rectangle().foregroundColor(Color.gray.opacity(0.4))
            }
        }
    }

    private var headerView: some View{
        VStack{
            Text(movie.titleWithLanguage)
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .center)
            
            HStack{
            Text("Release Date: \(movie.release_date ?? "-")")
                .font(.subheadline)
            }
            
        }.foregroundColor(.white)
        
    }
    
    private var moviePosterView: some View{
        HStack(alignment: .center){
            Spacer()
            imageView
                .frame(width: 200, height: 320)
                .cornerRadius(20)
            Spacer()
        }
    }
    
    private var movieOverView: some View{
        Text(movie.overview ?? "-")
            .font(.body)
            .foregroundColor(.white)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.top, 16)
    }
    
    private var reviewLink: some View{
        VStack{
            Divider()
            NavigationLink(destination:CommentView(MId:"\(movie.id!)",movieName:"\(movie.title!)")){
                HStack{
                    Text("Reviews")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.right").resizable().resizable()
                        .foregroundColor(Color.white)
                        .frame(width:20,
                               height:25).opacity(0.5)
                }
            }
            Divider()
        }
    }
    
    private var castInfo: some View{
        VStack(alignment: .leading){
            Text("CAST").foregroundColor(.white)
            ScrollView(.horizontal, showsIndicators: false){
                HStack(alignment: .top, spacing: 30){
                    ForEach(movieManager.cast){ cast in
                        
                        VStack{
                            AsyncImage(url: URL (string: cast.profilePhoto)!){
                                Rectangle().foregroundColor(Color.gray.opacity(0.4))
                            } image: { (img) -> Image in
                                Image(uiImage: img)
                                    .resizable()
                            }
                            .frame(width: 100, height: 160)
                            .animation(.easeIn(duration: 0.5))
                            .transition(.opacity)
                            .scaledToFill()
                            .cornerRadius(15)
                            .shadow(radius: 15)
                            
                            Text("\(cast.name ?? "-") as \(cast.character ?? "-")")
                                .font(.caption)
                                .foregroundColor(.white)
                                .frame(width: 100)
                                .fixedSize(horizontal: false, vertical: true)
                            
                        }
                    }
                }
            }
        }.onAppear(){
            movieManager.getCast(for: movie)
        }
    }

}
