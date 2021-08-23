import XCTest
@testable import HyperCouch

final class AttributeTests: XCTestCase {
    func testInit() {
        XCTAssertEqual(Attribute("name", value: "test").value, "test")
        XCTAssertNil(Attribute("", value: "test").value)
        XCTAssertNil(Attribute("name").value)
    }
    
    // MARK: CustomStringConvertible
    func testDescription() {
        XCTAssertEqual(Attribute("autofocus").description, "autofocus")
        XCTAssertEqual(Attribute("href", value: "index.html").description, "href=\"index.html\"")
        XCTAssertEqual(Attribute("href", value: "").description, "href=\"\"")
        XCTAssertEqual(Attribute("", value: "index.html").description, "")
        XCTAssertEqual(Attribute("").description, "")
    }
}
