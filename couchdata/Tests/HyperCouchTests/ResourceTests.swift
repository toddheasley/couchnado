import Testing
@testable import HyperCouch
import Foundation

struct ResourceTests {
    @Test func save() throws {
        let url: URL = URL(fileURLWithPath: NSTemporaryDirectory())
        let resource: Resource = try Resource("apple-touch-icon.png")
        try resource.save(url)
        let file: Data = try Data(contentsOf: URL(string: resource.name, relativeTo: url)!)
        #expect(file.count == 5172)
    }
    
    @Test func nameInit() throws {
        #expect(try Resource("share-image.png").data.count == 40711)
        #expect(try Resource("apple-touch-icon.png").data.count == 5172)
        #expect(try Resource("favicon.ico").data.count == 861)
        #expect(try Resource("wikipedia.svg").data.count == 2342)
        #expect(try Resource("apple-tv.svg").data.count == 2087)
        #expect(try Resource("netflix.svg").data.count == 2437)
        #expect(try Resource("index.html").data.count == 4010)
    }
}
