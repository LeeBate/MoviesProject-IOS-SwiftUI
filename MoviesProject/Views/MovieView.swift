//
//  MovieView.swift
//  MoviesProject
//
//  Created by suranaree09 on 19/5/2565 BE.
//

import SwiftUI

struct MovieView: View {
    
    @State private var searchBar = ""
    @State private var selectionIndex = 0
    @State private var tabs = ["Now Playing", "Upcoming", "Trending"]
    
    @ObservedObject var movieManager = MovieManagerLoad()
    
    init(){
        UITableView.appearance().backgroundColor = UIColor.clear
        UITableViewCell.appearance().selectionStyle = .none      
        UINavigationBar.appearance().backgroundColor = .clear
//        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = .orange
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.orange]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor:UIColor.orange]
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
        VStack{
            VStack(alignment: .leading){

                Text(tabs[selectionIndex])
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.red)
                    .padding(.top)
                    //.navigationBarTitle("Doo Movies", displayMode: .automatic)
                HStack{
                    Image(systemName: "magnifyingglass")
                        .imageScale(.medium)
                    
                    TextField("Search...", text: $searchBar)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                }
            }.padding(.horizontal)
            
            VStack{
                Picker("_", selection: $selectionIndex){
                    ForEach(0..<tabs.count){ index in
                        Text(tabs[index])
                            .font(.title)
                            .bold()
                            .tag(index)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                    .onChange(of: selectionIndex) { (_) in
                        if selectionIndex == 0 {
                            movieManager.getNowPlaying()
                        }else if selectionIndex == 1 {
                            movieManager.getUpcoming()
                        }else if selectionIndex == 2 {
                            movieManager.getPopular()
                        }
                    }.padding()

                List{
                    ForEach(movieManager.movies.filter{
                        searchBar.isEmpty ? true : $0.title?.lowercased().localizedStandardContains(searchBar.lowercased()) ?? true}) { movie in
                            NavigationLink(destination: MovieDetailView(movie: movie)){
                                MovieCell(movie: movie)
                            }.listRowBackground(Color.clear)
                        }
                }.onAppear(){
                    movieManager.getNowPlaying()
                }
            }
            Spacer()
        }
        .navigationBarHidden(true)
        
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView()
    }
}
