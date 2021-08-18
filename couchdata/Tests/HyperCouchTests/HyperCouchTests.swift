import XCTest
import CouchData
@testable import HyperCouch

final class HyperCouchTests: XCTestCase {
    func testSave() {
        let expectation: XCTestExpectation = XCTestExpectation()
        let data: CouchData = CouchData(Bundle.module.url(forResource: "index", withExtension: "tsv")!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            do {
                let url: URL = URL(fileURLWithPath: NSTemporaryDirectory())
                try HyperCouch(data).save(url)
            } catch {
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
