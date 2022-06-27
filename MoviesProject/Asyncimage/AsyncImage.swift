//
//  AsyncImage.swift
//  ProjectMovies
//
//  Created by suranaree09 on 11/5/2565 BE.
//

import SwiftUI
import XCTest

struct AsyncImage<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    
    private let placholder: Placeholder
    private let image: (UIImage) -> Image
    
    init(
        url: URL,
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)
    ){
        self.placholder = placeholder()
        self.image = image
        _loader = StateObject(wrappedValue: ImageLoader(url: url, cache: Environment(\.imgeCache).wrappedValue))
    }
    
    var body: some View{
        content.onAppear(perform: loader.load)
    }
    
    private var content: some View{
        Group{
            if  loader.image != nil{
                image(loader.image!)
            }else{
                placholder
            }
        }
    }
}
