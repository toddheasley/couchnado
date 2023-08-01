import XCTest
@testable import HyperCouch

final class ResourceTests: XCTestCase {
    func testSave() throws {
        let url: URL = URL(fileURLWithPath: NSTemporaryDirectory())
        let resource: Resource = try Resource("apple-touch-icon.png")
        try resource.save(url)
        let file: Data = try Data(contentsOf: URL(string: resource.name, relativeTo: url)!)
        XCTAssertEqual(file.count, 5172)
    }
    
    func testInit() throws {
        XCTAssertEqual(try Resource("share-image.png").data.count, 40711)
        XCTAssertEqual(try Resource("apple-touch-icon.png").data.count, 5172)
        XCTAssertEqual(try Resource("favicon.ico").data.count, 861)
        XCTAssertEqual(try Resource("wikipedia.svg").data.count, 2326)
        XCTAssertEqual(try Resource("apple-tv.svg").data.count, 2071)
        XCTAssertEqual(try Resource("netflix.svg").data.count, 2421)
        XCTAssertEqual(try Resource("index.html").data.count, 4131)
    }
}
