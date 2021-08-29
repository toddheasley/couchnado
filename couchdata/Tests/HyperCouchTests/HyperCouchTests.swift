import XCTest
import CouchData
@testable import HyperCouch

final class HyperCouchTests: XCTestCase {
    func testSave() {
        let expectation: XCTestExpectation = XCTestExpectation()
        let data: CouchData = CouchData(Bundle.module.url(forResource: "index", withExtension: "tsv")!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            do {
                let url: URL = try .base(relativeTo: URL(fileURLWithPath: NSTemporaryDirectory()))
                XCTAssertEqual(try HyperCouch(data).save(url), URL(string: "index.html", relativeTo: url))
                XCTAssertEqual(try Data(contentsOf: URL(string: "apple-touch-icon.png", relativeTo: url)!).count, 347)
                XCTAssertEqual(try Data(contentsOf: URL(string: "favicon.ico", relativeTo: url)!).count, 173)
                XCTAssertEqual(try Data(contentsOf: URL(string: "image.png", relativeTo: url)!).count, 2076)
                XCTAssertEqual(try Data(contentsOf: url).count, 5322)
            } catch {
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
