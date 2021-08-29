import XCTest
@testable import HyperCouch

final class ResourceTests: XCTestCase {
    func testSave() throws {
        let url: URL = URL(fileURLWithPath: NSTemporaryDirectory())
        let resource: Resource = try Resource("apple-touch-icon.png")
        try resource.save(url)
        let file: Data = try Data(contentsOf: URL(string: resource.name, relativeTo: url)!)
        XCTAssertEqual(file.count, 347)
    }
    
    func testInit() throws {
        XCTAssertEqual(try Resource("apple-touch-icon.png").data.count, 347)
        XCTAssertEqual(try Resource("favicon.ico").data.count, 173)
        XCTAssertEqual(try Resource("image.png").data.count, 2076)
        XCTAssertEqual(try Resource("index.html").data.count, 3807)
    }
}
