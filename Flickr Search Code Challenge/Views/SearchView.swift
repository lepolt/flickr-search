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

    var body: some View {
        VStack {
            TextField("Enter a search term", text: $viewModel.searchText)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .textFieldStyle(.roundedBorder)
                .padding()

            GeometryReader { geometry in
                List(viewModel.searchItems) { searchItem in
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
}

#Preview {
    SearchView()
}
