//
//  ContentRouter.swift
//  MovieChallenge
//
//  Created by Danny Narvaez on 15/12/21.
//

import SwiftUI

class ContentRouter {
    
    func makeDetailView(for content: ContentAdapter) -> some View {
        let presenter = ContentDetailPresenter(
            content: content,
            interactor: ContentDetailInteractor())
        return ContentDetailView(presenter: presenter)
    }
}
