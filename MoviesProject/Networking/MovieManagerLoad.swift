//
//  MovieManagerLoad.swift
//  ProjectMovies
//
//  Created by suranaree09 on 11/5/2565 BE.
//

import SwiftUI

final class MovieManagerLoad: ObservableObject{
    @Published var movies = [Movie]()
    @Published var cast = [Cast]()
    
    static var baseURL = "https://api.themoviedb.org/3/movie/"
    
    func getNowPlaying() {
        getMovies(movieUrl: .nowPlaying)
    }
    
    func getUpcoming(){
        getMovies(movieUrl: .upcoming)
    }
    
    func getPopular(){
        getMovies(movieUrl: .popular)
    }
    
    func getCast(for movie: Movie){
        let urlString = "\(Self.baseURL)\(movie.id ?? 100)/credits?api_key=\(API.key)&language=en-US"
        NetworkManager<CastResponse>.fetch(from: urlString) {(result) in
            switch result{
            case .success(let response):
                self.cast = response.cast
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func getMovies(movieUrl: MovieURL){
        NetworkManager<MovieRespones>.fetch(from: movieUrl.urlString){(result) in
            switch result{
            case .success(let movieResponse):
                self.movies = movieResponse.results
            case .failure(let err):
                print(err)
            }
        }
    }
}

