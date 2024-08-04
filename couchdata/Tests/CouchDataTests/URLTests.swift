import Testing
@testable import CouchData
import Foundation

struct URLTests {
    @Test func repo() {
        #expect(URL(string: "https://github.com/toddheasley/couchnado") == .repo)
    }
    
    @Test func docs() {
        #expect(URL(string: "https://toddheasley.github.io/couchnado/") == .docs)
    }
    
    @Test func data() {
        #expect(URL(string: "index.tsv", relativeTo: .docs) == .data)
    }
    
    @Test func nameData() throws {
        #expect(throws: URLError.self) {
            try URL.data("data", relativeTo: URL(string: "ftp://127.0.0.1")!)
        }
        #expect(throws: URLError.self) {
            try URL.data("", relativeTo: .docs)
        }
        var url: URL = try .data("data", relativeTo: .docs)
        #expect(url == URL(string: "data.tsv", relativeTo: .docs))
        let httpURL: URL = URL(string: "http://example.com/couchnado/")!
        url = try .data("data", relativeTo: httpURL)
        #expect(url == URL(string: "data.tsv", relativeTo: httpURL))
        let fileURL: URL = URL(fileURLWithPath: "file:///Users/toddheasley/Documents/")
        url = try .data("Data File", relativeTo: fileURL)
        #expect(url == URL(string: "Data%20File.tsv", relativeTo: fileURL))
    }
}

extension URLTests {
    @Test func service() {
        #expect(URL(string: "https://en.wikipedia.org")?.service == .wikipedia)
        #expect(URL(string: "https://tv.apple.com")?.service == .apple)
        #expect(URL(string: "https://www.netflix.com")?.service == .netflix)
        #expect(URL(string: "https://hbo.com")?.service == nil)
    }
}
