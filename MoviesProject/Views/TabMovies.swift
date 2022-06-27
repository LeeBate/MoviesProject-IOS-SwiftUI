//
//  TabMovies.swift
//  MoviesProject
//
//  Created by suranaree09 on 19/5/2565 BE.
//

import SwiftUI

enum Tab: Int{
    case movie
    case discover
}

struct TabMovies: View {
    
    @State private var selectedTab = Tab.movie
    
    var body: some View {
        TabView(selection: $selectedTab){
            MovieView().tabItem{
                tabBarItem(text: "Movies", image: "film")
            }.tag(Tab.movie)
            FavoriteView().tabItem{
                tabBarItem(text: "Favorite", image: "square.stack")
            }.tag(Tab.discover)
            ProfileView().tabItem{
                tabBarItem(text: "Profile", image: "person")
            }
        }
    }
    
    private func tabBarItem(text: String, image: String) -> some View{
        VStack{
            Image(systemName: image)
                .imageScale(.large)
            
            Text(text)
        }
    }
}

struct TabMovies_Previews: PreviewProvider {
    static var previews: some View {
        TabMovies()
    }
}
