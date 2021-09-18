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
        XCTAssertEqual(try Resource("image.png").data.count, 50215)
        XCTAssertEqual(try Resource("apple-touch-icon.png").data.count, 5172)
        XCTAssertEqual(try Resource("favicon.ico").data.count, 861)
        XCTAssertEqual(try Resource(URL.Service.wikipedia.name).data.count, 3173)
        XCTAssertEqual(try Resource(URL.Service.apple.name).data.count, 3286)
        XCTAssertEqual(try Resource(URL.Service.netflix.name).data.count, 3014)
        XCTAssertEqual(try Resource("index.html").data.count, 3860)
    }
}
