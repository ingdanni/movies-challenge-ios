//
//  ContentView.swift
//  MovieChallenge
//
//  Created by Danny Narvaez on 15/12/21.
//

import SwiftUI

struct ContentView: View {
    
    var title: String
    
    @ObservedObject var presenter: ContentPresenter
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack {
                        ForEach(Category.allCases, id: \.rawValue) { item in
                            Button(item.title, action: {
                                presenter.selectedCategory = item
                            })
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                })
                
                ScrollView {
                    ForEach(presenter.list, id: \.contentId) { item in
                        self.presenter.detailLinkBuilder(for: item) {
                            ContentListItem(title: item.contentTitle, url: item.contentImage)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle(title)
        }
    }
}
