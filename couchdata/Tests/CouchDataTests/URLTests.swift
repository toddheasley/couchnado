import XCTest
@testable import CouchData

final class URLTests: XCTestCase {
    
}

extension URLTests {
    func testRepo() {
        XCTAssertEqual(URL.repo, URL(string: "https://github.com/toddheasley/couchnado"))
    }
    
    func testDocs() {
        XCTAssertEqual(URL.docs, URL(string: "https://toddheasley.github.io/couchnado/"))
    }
    
    func testData() {
        XCTAssertEqual(URL.data, URL(string: "index.tsv", relativeTo: .docs))
    }
    
    func testNameData() throws {
        var url: URL = try .data("data", relativeTo: .docs)
        XCTAssertEqual(url, URL(string: "data.tsv", relativeTo: .docs))
        let httpURL: URL = URL(string: "http://example.com/couchnado/")!
        url = try .data("data", relativeTo: httpURL)
        XCTAssertEqual(url, URL(string: "data.tsv", relativeTo: httpURL))
        let fileURL: URL = URL(fileURLWithPath: "file:///Users/toddheasley/Documents/")
        url = try .data("Data File", relativeTo: fileURL)
        XCTAssertEqual(url, URL(string: "Data%20File.tsv", relativeTo: fileURL))
        XCTAssertThrowsError(try URL.data("data", relativeTo: URL(string: "ftp://127.0.0.1")!)) { error in
            XCTAssertEqual(error as? URLError, URLError(.unsupportedURL))
        }
        XCTAssertThrowsError(try URL.data("", relativeTo: .docs)) { error in
            XCTAssertEqual(error as? URLError, URLError(.badURL))
        }
    }
}

extension URLTests {
    func testService() {
        XCTAssertEqual(URL(string: "https://en.wikipedia.org")!.service, .wikipedia)
        XCTAssertEqual(URL(string: "https://tv.apple.com")!.service, .apple)
        XCTAssertEqual(URL(string: "https://www.netflix.com")!.service, .netflix)
        XCTAssertNil(URL(string: "https://hbo.com")!.service)
    }
}
