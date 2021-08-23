import XCTest
@testable import HyperCouch

final class ArrayTests: XCTestCase {
    
}

extension ArrayTests {
    func testDescription() {
        XCTAssertEqual(["", ""].description(true), "    \n    ")
        XCTAssertEqual(["", "    ", ""].description(true), "    \n        \n    ")
        XCTAssertEqual(["", ""].description(), "\n")
        XCTAssertEqual([""].description(), "")
        XCTAssertEqual([].description(), "")
    }
}
