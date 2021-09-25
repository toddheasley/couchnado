import XCTest
@testable import HyperCouch

final class RGBATests: XCTestCase {
    func testCGFloatInit() {
        let rgba: RGBA = RGBA(0.5, 255.0, -1.0, 0.75)
        XCTAssertEqual(rgba.red, 0.5)
        XCTAssertEqual(rgba.green, 1.0)
        XCTAssertEqual(rgba.blue, 0.0)
        XCTAssertEqual(rgba.alpha, 0.75)
    }
    
    func testIntInit() {
        var rgba: RGBA = RGBA(127, 1000, -37, 0.75)
        XCTAssertEqual(rgba.red, 0.5, accuracy: 0.01)
        XCTAssertEqual(rgba.green, 1.0)
        XCTAssertEqual(rgba.blue, 0.0)
        XCTAssertEqual(rgba.alpha, 0.75)
        rgba = RGBA(203, 229, 209)
        XCTAssertEqual(rgba.red, 0.8, accuracy: 0.01)
        XCTAssertEqual(rgba.green, 0.9, accuracy: 0.01)
        XCTAssertEqual(rgba.blue, 0.82, accuracy: 0.01)
        XCTAssertEqual(rgba.alpha, 1.0)
    }
    
    // MARK: CustomStringConvertible
    func testDescription() {
        XCTAssertEqual(RGBA(0.5, 1.0, 0.0, 0.75).description, "rgba(127, 255, 0, 0.75)")
        XCTAssertEqual(RGBA(203, 229, 209).description, "rgb(203, 229, 209)")
    }
}
