//
//  ContentDetailView.swift
//  MovieChallenge
//
//  Created by Danny Narvaez on 16/12/21.
//

import SwiftUI

struct ContentDetailView: View {
    @ObservedObject var presenter: ContentDetailPresenter
    
    var body: some View {
        VStack {
            Text(presenter.content.contentId.description)
            Text(presenter.content.contentTitle)
            Text(presenter.content.contentOverview)
        }
    }
}
