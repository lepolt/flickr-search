
import XCTest
@testable import Flickr_Search_Code_Challenge

final class RequestTypeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRequestMethod() {
        let request = RequestType.search(tags: "")
        XCTAssertEqual(request.httpMethod, .get)
    }

    func testRequest() throws {
        let expected = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=fake,tags"
        let request = try XCTUnwrap(RequestType
            .search(tags: "fake,tags")
            .request
        )
        
        XCTAssertEqual(expected, request.url?.absoluteString)
    }

}
