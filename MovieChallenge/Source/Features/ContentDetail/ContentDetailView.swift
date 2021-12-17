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
        ScrollView {
            VStack {
                AsyncImage(
                    url: URL(string: presenter.content.contentImage)!,
                    placeholder: {
                        Text("Loading...")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }, image: {
                        Image(uiImage: $0)
                            .resizable()
                    })
                    .frame(idealWidth: UIScreen.main.bounds.width / 2 * 3, maxHeight: 400)
                
                Text(presenter.content.contentTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .font(.title)
                    .padding(16)
                
                Text(presenter.content.contentOverview)
                    .padding(16)
            }
        }
    }
}
