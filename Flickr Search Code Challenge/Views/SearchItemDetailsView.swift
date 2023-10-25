
import Foundation
import SwiftUI

// MARK: - SearchItemDetailsView

/// Details view for a Search Item
struct SearchItemDetailsView: View {
    /// URL of the image to display
    let imageUrl: String

    /// CGSize of the image
    let imageSize: CGSize

    /// URL to view the details of this image on Flickr
    let detailsUrl: URL?

    /// Title of the image
    let title: String

    /// The `Date` this photo was taken
    let dateTaken: Date

    /// Author who took the photo
    let author: String

    /// Tags of the image, separated by space
    let tags: String

    // TODO JEL: We should move this into a view model to make it testable
    /// List of tag strings for this image
    var tagsList: [String] {
        tags.components(separatedBy: " ")
    }

    var body: some View {
        VStack {
            ScrollView {
            VStack {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image

                    Text("(w: \(imageSize.width.formatted()), h: \(imageSize.height.formatted()))")
                        .font(.caption)

                } placeholder: {
                    ProgressView()
                }

                Text(title)
                    .font(.title)

                VStack {
                    Text(author)
                        .font(.subheadline)

                    Text(dateTaken.formatted(date: .abbreviated, time: .shortened))
                        .font(.footnote)

                        // TODO JEL: This is not ideal. Tags can vary in width and we don't know how many to display on 
                        // a row, but for a demo I think it's okay. Also right now we are not allowing the text to wrap
                        // or stretch because of how Grid works. 
                        LazyVGrid(
                            columns: [GridItem(.adaptive(minimum: 100))],
                            spacing: 5
                        ) {
                            ForEach(tagsList, id: \.self) { tag in
                                Text(tag)
                                    .lineLimit(1)
                                    .makeTag(color: .blue.opacity(0.5))
                            }
                        }
                    }

                    Spacer()
                }
                .padding()
                
            }

            if let detailsUrl {
                Link("View on Flickr", destination: detailsUrl)
            }
        }
    }
}

#Preview {
    SearchItemDetailsView(
        imageUrl: "https://live.staticflickr.com/65535/53275500189_fe7b07263f_m.jpg",
        imageSize: .init(width: 227, height: 240),
        detailsUrl: URL(string: "https://www.flickr.com/photos/zoomzoomslittleadventures/53284589546"),
        title: "North American Porcupine",
        dateTaken: Date(),
        author: "nobody@flickr.com (Tom Kilroy)",
        tags: "porcupine albuquerque bosque tingleybeach more tags here so that we wrap a litte more"
    )
}
