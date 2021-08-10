import XCTest
@testable import CouchData

final class URLTests: XCTestCase {
    
}

extension URLTests {
    func testService() {
        XCTAssertEqual(URL(string: "https://en.wikipedia.org")!.service, .wikipedia)
        XCTAssertEqual(URL(string: "https://tv.apple.com")!.service, .apple)
        XCTAssertEqual(URL(string: "https://www.netflix.com")!.service, .netflix)
        XCTAssertNil(URL(string: "https://hbo.com")!.service)
    }
}
