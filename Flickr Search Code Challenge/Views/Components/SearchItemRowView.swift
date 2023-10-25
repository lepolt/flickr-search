//
//  SearchItemRowView.swift
//  Flickr Search Code Challenge
//
//  Created by Jonathan Lepolt on 10/25/23.
//

import SwiftUI

struct SearchItemRowView: View {
    let thumbnailUrl: String
    let title: String
    let author: String
    let imageSize: CGFloat

    var body: some View {
        HStack {
            // TODO JEL: It's a known issue that AsyncImage doesn't cache
            AsyncImage(url: URL(string: thumbnailUrl)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: imageSize, maxHeight: imageSize)
                    .clipped()
            } placeholder: {
                ProgressView()
            }

            VStack(alignment: .leading) {
                // TODO JEL: These titles have varying lengths. I would probably think more about adding ... and/or
                // specifying a line limit, but since we don't have designers or specific requirements around this
                // I'll let it go for now.
                Text(title)
                    .font(.subheadline)
                    .bold()

                Text(author)
                    .font(.caption)

                Spacer()
            }

            Spacer()
        }
    }
}

#Preview {
    SearchItemRowView(
//        thumbnailUrl: "https://live.staticflickr.com/65535/53275500189_fe7b07263f_m.jpg",
        thumbnailUrl: "https://live.staticflickr.com//65535//53284746080_c9d782dac8_m.jpg",
        title: "North American Porcupine",
        author: "nobody@flickr.com (Tom Kilroy)", 
        imageSize: 100
    )
    .frame(maxWidth: .infinity)
}
