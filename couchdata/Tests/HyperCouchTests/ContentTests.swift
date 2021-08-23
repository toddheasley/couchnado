import XCTest
@testable import HyperCouch

final class ContentTests: XCTestCase {
    func testInit() {
        let content: [Content] = ["<div>", "    <p></p>", "</div>"]
        XCTAssertEqual(Content(content, indent: true).description, "    <div>\n        <p></p>\n    </div>")
        XCTAssertEqual(Content(content).description, content.description())
        XCTAssertEqual(Content().description, "")
    }
}
