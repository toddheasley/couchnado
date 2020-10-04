import XCTest
@testable import CouchData

final class StringTests: XCTestCase {
    
}

extension StringTests {
    
    // MARK: Value
    func testValue() {
        XCTAssertEqual(" Science Fiction \n".value, "science fiction")
        
    }
    
    func testvalueInit() {
        XCTAssertEqual(String(value: "\nScience fiction"), "science fiction")
        XCTAssertNil(String(value: " "))
        XCTAssertNil(String(value: ""))
    }
}
