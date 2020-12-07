import XCTest
@testable import CouchData

final class URLTests: XCTestCase {
    
}

extension URLTests {
    func testService() {
        XCTAssertEqual(URL(string: "https://en.wikipedia.org")?.service, .wikipedia)
        XCTAssertEqual(URL(string: "https://tv.apple.com")?.service, .apple)
        XCTAssertEqual(URL(string: "https://www.netflix.com")?.service, .netflix)
        XCTAssertEqual(URL(string: "https://www.disneyplus.com")?.service, .disney)
        XCTAssertEqual(URL(string: "https://www.amazon.com")?.service, .amazon)
        XCTAssertEqual(URL(string: "https://www.hulu.com")?.service, .hulu)
        XCTAssertEqual(URL(string: "https://www.hbo.com")?.service, .hbo)
    }
}
