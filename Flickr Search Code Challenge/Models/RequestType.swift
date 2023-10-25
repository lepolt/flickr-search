
import Foundation

// MARK: - RequestMethod

/// Define the HTTP request types on an enum for easy access
enum RequestMethod: String {
    case get = "GET"
}

// MARK: - RequestError

/// Describes some error with our request
enum RequestError: Error {
    /// There is a problem with the specified URL
    case invalidUrl
}

// MARK: - RequestType

/// Define the types of requests made in the app.
enum RequestType {
    case search(tags: String)

    /// The HTTP method for this request
    var httpMethod: RequestMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    /// Builds a complete `URLRequest` for a `RequestType`. Throws if there are errors.
    var request: URLRequest {
        get throws {
            guard var url = URL(string: Constants.baseUrlString) else {
                throw RequestError.invalidUrl
            }
            url.append(queryItems: queryParams)

            var request = URLRequest(url: url)
            request.httpMethod = httpMethod.rawValue

            return request
        }
    }
    
    /// Returns the query parameters needed to build a specific request
    private var queryParams: [URLQueryItem] {
        // All requests need these query parameters
        var params = [
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "nojsoncallback", value: "1")
        ]

        // Append params for each request type
        switch self {
        case .search(let tags):
            params.append(
                URLQueryItem(name: "tags", value: tags)
            )
        }

        return params
    }
}
