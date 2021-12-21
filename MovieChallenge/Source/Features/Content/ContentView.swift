//
//  ContentView.swift
//  MovieChallenge
//
//  Created by Danny Narvaez on 15/12/21.
//

import SwiftUI

struct ContentView: View {
    
    var title: String
    var tabs: [Category]
    
    @ObservedObject var presenter: ContentPresenter
    
    @State var searchText: String = ""
    @State var isSearching: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                searchBar
                categoriesHeader
                contentList
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: Header
    
    var categoriesHeader: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack {
                ForEach(tabs, id: \.rawValue) { item in
                    Button(item.title, action: {
                        presenter.selectedCategory = item
                    })
                    .font(
                        item == presenter.selectedCategory
                        ? Font.system(size: 18)
                        : Font.system(size: 16))
                    .foregroundColor(
                        item == presenter.selectedCategory
                        ? Color.gray
                        : Color.white)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        })
    }
    
    // MARK: List
    
    var contentList: some View {
        ScrollView {
            LazyVStack {
                if presenter.list.isEmpty {
                    ProgressView("Loading...")
                        .padding(.vertical, 40)
                } else {
                    listItems
                }
            }
        }
    }
    
    var listItems: some View {
        Group {
            ForEach(presenter.list, id: \.contentId) { item in
                self.presenter.detailLinkBuilder(for: item) {
                    ContentListItem(title: item.contentTitle, url: item.contentImage)
                        .onAppear {
                            if !isSearching, item.contentId == presenter.list.last?.contentId {
                                loadMoreItems()
                            }
                        }
                }
            }
        }
    }
    
    // MARK: Search
    
    var searchBar: some View {
        HStack {
            TextField("Search", text: $searchText)
                .padding(8)
                .padding(.horizontal, 8)
                .cornerRadius(8)
                .padding(.horizontal, 8)
                .onTapGesture {
                    isSearching = true
                }
                .onChange(of: searchText) { value in
                    presenter.search(value)
                }
            
            if isSearching {
                Button(action: {
                    isSearching = false
                    searchText = ""
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 8)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
    
    // MARK: Methods
    
    func loadMoreItems() {
        presenter.loadMore()
    }
}
