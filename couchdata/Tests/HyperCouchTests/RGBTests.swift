import XCTest
@testable import HyperCouch

final class RGBATests: XCTestCase {
    func testCGFloatInit() {
        let rgb: RGB = RGB(0.5, 255.0, -1.0, 0.75)
        XCTAssertEqual(rgb.red, 0.5)
        XCTAssertEqual(rgb.green, 1.0)
        XCTAssertEqual(rgb.blue, 0.0)
        XCTAssertEqual(rgb.alpha, 0.75)
    }
    
    func testIntInit() {
        var rgb: RGB = RGB(127, 1000, -37, 0.75)
        XCTAssertEqual(rgb.red, 0.5, accuracy: 0.01)
        XCTAssertEqual(rgb.green, 1.0)
        XCTAssertEqual(rgb.blue, 0.0)
        XCTAssertEqual(rgb.alpha, 0.75)
        rgb = RGB(203, 229, 209)
        XCTAssertEqual(rgb.red, 0.8, accuracy: 0.01)
        XCTAssertEqual(rgb.green, 0.9, accuracy: 0.01)
        XCTAssertEqual(rgb.blue, 0.82, accuracy: 0.01)
        XCTAssertEqual(rgb.alpha, 1.0)
    }
    
    // MARK: CustomStringConvertible
    func testDescription() {
        XCTAssertEqual(RGB(0.5, 1.0, 0.0, 0.75).description, "rgba(127, 255, 0, 0.75)")
        XCTAssertEqual(RGB(203, 229, 209).description, "rgb(203, 229, 209)")
    }
}
