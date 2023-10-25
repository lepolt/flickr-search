
import Foundation

// MARK: - SearchItem

/// struct to define a search item returned from the Flickr API
struct SearchItem {
    struct Media: Decodable, Hashable {
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

/// Hashable so we can use `NavigationPath`
extension SearchItem: Hashable {}

// TODO JEL: make `tags` property an array of [String]. This requires a custom decoder and at this point it's not worth
// spending the time to implement.
// TODO JEL: I don't like "_" in variable names, so I would like to change those names. I could do this pretty easily
// with coding keys, but am not doing that right now.

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
