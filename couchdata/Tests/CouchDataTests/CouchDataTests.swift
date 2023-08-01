import XCTest
import SwiftUI
@testable import CouchData

final class CouchDataTests: XCTestCase {
    func testLoad() {
        let expectation: XCTestExpectation = XCTestExpectation()
        let data: CouchData = CouchData()
        XCTAssertTrue(data.videos.isEmpty)
        XCTAssertTrue(data.genres.isEmpty)
        XCTAssertNil(data.error)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertTrue(!data.videos.isEmpty)
            XCTAssertTrue(!data.genres.isEmpty)
            XCTAssertNil(data.error)
            data.load(Bundle.module.url(forResource: "index", withExtension: "tsv")!)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                XCTAssertEqual(data.videos.count, 6)
                XCTAssertEqual(data.genres.count, 3)
                XCTAssertNil(data.error)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
}
#if os(macOS) || os(iOS)

extension CouchDataTests {
    
    // MARK: Portable
    func testContentType() {
        XCTAssertEqual(CouchData.contentType, .tabSeparatedText)
    }
    
    func testDefaultFilename() {
        XCTAssertEqual(CouchData.defaultFilename, "index")
    }
    
    func testFile() {
        let expectation: XCTestExpectation = XCTestExpectation()
        let data: CouchData = CouchData(Bundle.module.url(forResource: "index", withExtension: "tsv")!)
        XCTAssertNil(data.file)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertNotNil(data.file as? Spreadsheet)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
#endif
