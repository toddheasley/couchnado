import XCTest
@testable import HyperCouch

final class URLTests: XCTestCase {
    
}

extension URLTests {
    func testBase() {
        XCTAssertEqual(URL.base, URL(string: "index.html", relativeTo: .docs))
    }
    
    func testNameBase() throws {
        XCTAssertEqual(try .base("base", relativeTo: .docs), URL(string: "base.html", relativeTo: .docs))
        let url: URL = URL(fileURLWithPath: "file:///Users/toddheasley/Documents/")
        XCTAssertEqual(try .base(relativeTo: url), URL(string: "index.html", relativeTo: url))
        
    }
    
    func testStringBase() throws {
        XCTAssertEqual(try URL.base(string: "apple-touch-icon.png"), URL(string: "apple-touch-icon.png", relativeTo: .docs))
        let url: URL = URL(fileURLWithPath: "file:///Users/toddheasley/Documents/")
        XCTAssertEqual(try URL.base(string: "favicon.ico", relativeTo: url), URL(string: "favicon.ico", relativeTo: url))
    }
}
