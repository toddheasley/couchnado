import XCTest
import CouchData
@testable import HyperCouch

final class HyperCouchTests: XCTestCase {
    
}
#if os(macOS) || os(iOS)

extension HyperCouchTests {
    
    // MARK: Exportable
    func testContentType() {
        XCTAssertEqual(HyperCouch.contentType, .html)
    }
    
    func testDefaultFilename() {
        XCTAssertEqual(HyperCouch.defaultFilename, "index")
    }
    
    func testFile() {
        let expectation: XCTestExpectation = XCTestExpectation()
        let data: CouchData = CouchData(Bundle.module.url(forResource: "index", withExtension: "tsv")!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertNotNil(HyperCouch(data).file as? WebPage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
#endif
