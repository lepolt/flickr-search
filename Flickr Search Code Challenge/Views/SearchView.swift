//
//  SearchView.swift
//  Flickr Search Code Challenge
//
//  Created by Jonathan Lepolt on 10/25/23.
//

import SwiftUI

struct SearchView: View {
    /// The view model to use on this view
    @StateObject private var viewModel = SearchViewModel()
    
    /// `NavigationPath` for our nav stack so we can show image details
    @State private var path: NavigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                TextField("Enter a search term", text: $viewModel.searchText)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .textFieldStyle(.roundedBorder)
                    .padding()

                GeometryReader { geometry in
                    List(viewModel.searchItems) { searchItem in
                        NavigationLink(value: searchItem) {
                            SearchItemRowView(
                                thumbnailUrl: searchItem.media.m,
                                title: searchItem.title,
                                author: searchItem.author,
                                imageSize: geometry.size.width * 0.20 // Let image be ~20% of the width of our view
                            )
                        }
                    }
                }
            }
            .navigationDestination(for: SearchItem.self) { searchItem in
                SearchItemDetailsView(
                    imageUrl: searchItem.media.m,
                    imageSize: ImageHelper.parseSize(html: searchItem.description), 
                    detailsUrl: ImageHelper.parseHref(html: searchItem.description),
                    title: searchItem.title,
                    dateTaken: searchItem.date_taken,
                    author: searchItem.author,
                    tags: searchItem.tags
                )
            }
        }
    }
}

#Preview {
    SearchView()
}
