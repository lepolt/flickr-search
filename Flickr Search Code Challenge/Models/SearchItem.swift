
import Foundation

// MARK: - SearchItem

/// struct to define a search item returned from the Flickr API
struct SearchItem {
    struct Media: Decodable {
        let m: String
    }

    let title: String
    let link: String
    let media: Media
    let date_taken: Date
    let description: String
    let published: Date
    let author: String
    let author_id: String
    let tags: String
}

// MARK: Extensions

extension SearchItem: Decodable {}

extension SearchItem: Identifiable {
    /// Unique identifier for a `SearchItem`. This isn't specified in the API docs but link should be unique.
    var id: String { link }
}
// TODO JEL: parse author_id as Int
// TODO JEL: make `tags` property array. Custom decoder
// TODO JEL: I don't like _ in variable names, so I might change that but again it requires a custom decoder

// MARK: - SearchItemsResponse

/// struct that defines the response from the Flickr search API
struct SearchItemsResponse {
    let title: String
    let link: String
    let description: String
    let modified: String
    let generator: String
    let items: [SearchItem]
}

// MARK: Extensions

extension SearchItemsResponse: Decodable {}
