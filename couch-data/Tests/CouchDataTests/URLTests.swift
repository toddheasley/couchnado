import XCTest
@testable import CouchData

final class URLTests: XCTestCase {
    
}

extension URLTests {
    func testService() {
        XCTAssertEqual(URL(string: "https://tv.apple.com")?.service, .apple)
        XCTAssertEqual(URL(string: "https://hulu.com")?.service, .hulu)
        XCTAssertEqual(URL(string: "https://netflix.com")?.service, .netflix)
        XCTAssertEqual(URL(string: "https://watch.amazon.com")?.service, .prime)
        XCTAssertEqual(URL(string: "https://en.wikipedia.org")?.service, .wikipedia)
    }
}
