import Testing
@testable import HyperCouch
import Foundation

struct URLTests {
    @Test func base() {
        #expect(URL(string: "index.html", relativeTo: .docs) == .base)
    }
    
    @Test func nameBase() {
        #expect(URL(string: "base.html", relativeTo: .docs) == (try! .base("base", relativeTo: .docs)))
        let url: URL = URL(fileURLWithPath: "file:///Users/toddheasley/Documents/")
        #expect(URL(string: "index.html", relativeTo: url) == (try! .base(relativeTo: url)))
    }
    
    @Test func stringBase() throws {
        #expect(try! URL.base(string: "apple-touch-icon.png") == URL(string: "apple-touch-icon.png", relativeTo: .docs))
        let url: URL = URL(fileURLWithPath: "file:///Users/toddheasley/Documents/")
        #expect(try! URL.base(string: "favicon.ico", relativeTo: url) == URL(string: "favicon.ico", relativeTo: url))
    }
}
