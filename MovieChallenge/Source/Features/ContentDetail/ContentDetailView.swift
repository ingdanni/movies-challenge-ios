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
                    url: presenter.content.contentImage,
                    placeholder: {
                        Image(systemName: "play.square")
                            .font(.system(size: 200))
                            .frame(maxWidth: .infinity, idealHeight: 250)
                            .foregroundColor(Color.gray)
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
