import XCTest
@testable import CouchData

final class CircaTests: XCTestCase {
    
    // MARK: RawRepresentable
    func Value() {
        XCTAssertEqual(Circa(value: "1964-2020")?.value, "1964-2020")
        XCTAssertEqual(Circa(value: "1980-1988, 2018-2020")?.value, "1980-1988, 2018-2020")
        XCTAssertEqual(Circa(value: "1990-1991, 2017")?.value, "1990-1991, 2017")
        XCTAssertEqual(Circa(value: "1990-1991, 2017")?.value, "1990-1991, 2017")
        XCTAssertEqual(Circa(value: "1968")?.value, "1968")
    }
    
    func testvalueInit() {
        XCTAssertEqual(Circa(value: "1964-2020")?.years, [1964...2020])
        XCTAssertEqual(Circa(value: "1980-1988,2018-2020")?.years, [1980...1988, 2018...2020])
        XCTAssertEqual(Circa(value: "1990-1991,2017")?.years, [1990...1991, 2017...2017])
        XCTAssertEqual(Circa(value: "1968")?.years, [1968...1968])
        XCTAssertNil(Circa(value: "1991-1990"))
        XCTAssertNil(Circa(value: ""))
    }
}
