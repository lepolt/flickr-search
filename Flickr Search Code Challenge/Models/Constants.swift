
import Foundation

/// struct to define our constants used throughout the app.
struct Constants {
    /// Private init so no one actually initializes and uses this object. I could probably have gone with an enum here
    /// instead of a struct but this is low risk and if someone wants to create a `Constants` object it won't hurt
    /// anything.
    private init() {}

    /// The base URL string to use for all requests in the app
    static let baseUrlString = "https://api.flickr.com/services/feeds/photos_public.gne"
}
