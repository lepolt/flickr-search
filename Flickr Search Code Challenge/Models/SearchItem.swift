
import Foundation

// MARK: - SearchItem

/// struct to define a search item returned from the Flickr API
struct SearchItem {
    let title: String
    let link: String
    let media: String
    let date_taken: String
    let description: String
    let published: Date
    let author: String
    let author_id: String
    let tags: String
}

// MARK: Extensions

extension SearchItem: Decodable {}
// TODO JEL: parse author_id as Int
// TODO JEL: make `tags` property array. Custom decoder

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

extension SearchItemsResponse {}
