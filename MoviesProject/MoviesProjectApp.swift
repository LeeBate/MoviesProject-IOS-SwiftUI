//
//  MoviesProjectApp.swift
//  MoviesProject
//
//  Created by suranaree09 on 19/5/2565 BE.
//

import SwiftUI
import Firebase

@main
struct MoviesProjectApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
