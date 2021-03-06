//
//  AsynImage.swift
//  MovieChallenge
//
//  Created by Danny Narvaez on 17/12/21.
//

import SwiftUI

struct AsyncImage<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    
    private let placeholder: Placeholder
    private let image: (UIImage) -> Image
    
    init(url: String,
         @ViewBuilder placeholder: () -> Placeholder,
         @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)) {
        
        self.placeholder = placeholder()
        self.image = image
        
        _loader = StateObject(wrappedValue: ImageLoader(url: URL(string: url)!))
    }
    
    var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    
    private var content: some View {
        Group {
            if loader.image != nil {
                image(loader.image!)
            } else {
                placeholder
            }
        }
    }
}
