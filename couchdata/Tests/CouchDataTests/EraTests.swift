import XCTest
@testable import CouchData

final class EraTests: XCTestCase {
    
    // MARK: Value
    func testValue() {
        XCTAssertEqual(Era(value: "1964-2020")?.value, "1964-2020")
        XCTAssertEqual(Era(value: "1980-1988, 2018-2020")?.value, "1980-1988, 2018-2020")
        XCTAssertEqual(Era(value: "1990-1991, 2017-")?.value, "1990-1991, 2017-")
        XCTAssertEqual(Era(value: "1990-1991, 2017")?.value, "1990-1991, 2017")
        XCTAssertEqual(Era(value: "2019-")?.value, "2019-")
        XCTAssertEqual(Era(value: "1968")?.value, "1968")
    }
    
    func testvalueInit() {
        XCTAssertEqual(Era(value: "1964-2020")?.years, [1964...2020])
        XCTAssertEqual(Era(value: "1980-1988,2018-2020")?.years, [1980...1988, 2018...2020])
        XCTAssertEqual(Era(value: "1990-1991,2017-")?.years, [1990...1991, 2017...Int.max])
        XCTAssertEqual(Era(value: "1990-1991,2017")?.years, [1990...1991, 2017...2017])
        XCTAssertEqual(Era(value: "1968")?.years, [1968...1968])
        XCTAssertEqual(Era(value: "2019-")?.years, [2019...Int.max])
        XCTAssertNil(Era(value: "1991-1990"))
        XCTAssertNil(Era(value: ""))
    }
}
