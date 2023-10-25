//
//  SearchViewModel.swift
//  Flickr Search Code Challenge
//
//  Created by Jonathan Lepolt on 10/25/23.
//

import Combine
import Foundation

// MARK: - SearchViewModel

/// View model to hold logic used in the `SearchView`
class SearchViewModel: ObservableObject {
    /// List of search items returned from the Flickr API
    @Published private(set) var searchItems: [SearchItem] = []
    
    /// The current error fetching data, if there was one
    @Published private(set) var error: String?

    /// The current user-entered search text
    @Published var searchText = ""

    /// URLSession to use for our requests.
    private let urlSession: URLSession
    
    /// Stores our Cancellables so we can observe changes to published vars
    private var cancellables = Set<AnyCancellable>()

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession

        setupObservers()
    }

    /// Clears our search text so user doesn't need to backspace away
    // TODO JEL: <#comment#>
//    func clear() {
//        searchText = ""
//    }

    // TODO JEL: is loading

    // MARK: - private functions
    
    /// Sets up all our observers so we can react when values change.
    private func setupObservers() {
        // We don't need to unsubscribe because everything will be destroyed when the Set goes out of scope.
        $searchText
            .sink { [weak self] search in
                self?.searchDidChange(value: search)
            }
            .store(in: &cancellables)
    }

    // TODO JEL: Ideally we would NOT hit the API each time the search string changes... we might debounce for a
    // couple seconds and wait until the user is done typing. However, the acceptance criteria explicitly says,
    // "The search results should be updated after each keystroke or change to the search string."
    /// Call this function when our search value changes.
    /// - Parameter value: The new value
    private func searchDidChange(value: String) {
        // Clear our search items if the query string is empty. No sense searching for nothing.
        guard !value.isEmpty else {
            searchItems = []
            return
        }

        // Don't block the main thread
        Task {
            await doSearch(tags: value)
        }
    }

    // TODO JEL: Docs
    private func doSearch(tags: String) async {
        do {
            let request = try RequestType.search(tags: tags).request
            let (data, response) = try await urlSession.data(for: request)

            // Check for 2xx response from server
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                // TODO JEL: Better error handling.
                error = "Error parsing response from server"
                return
            }


            // TODO JEL: If we have multiple requests that need to decode json and use a custom date strategy, pull
            // this decoder out somewhere and reuse it.
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            let itemsResponse = try decoder.decode(SearchItemsResponse.self, from: data)

            DispatchQueue.main.async { [weak self] in
                self?.searchItems = itemsResponse.items
            }

        } catch let error as NSError {
            print("Error searching: \(error), \(error.userInfo)")
        }
    }
}
