import XCTest
import CouchData
@testable import HyperCouch

final class IndexTests: XCTestCase {
    func testSave() {
        let expectation: XCTestExpectation = XCTestExpectation()
        let data: CouchData = CouchData(Bundle.module.url(forResource: "index", withExtension: "tsv")!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            do {
                let url: URL = try .base(relativeTo: URL(fileURLWithPath: NSTemporaryDirectory()))
                XCTAssertEqual(try Index(data, title: "HyperCouch").save(url), URL(string: "index.html", relativeTo: url))
                let file: Data = try Data(contentsOf: url)
                XCTAssertEqual(file.count, 3749)
            } catch {
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testInit() {
        let expectation: XCTestExpectation = XCTestExpectation()
        let data: CouchData = CouchData(Bundle.module.url(forResource: "index", withExtension: "tsv")!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            do {
                let index: Index = try Index(data, title: "Couchnado")
                XCTAssertEqual(index.description.data(using: .utf8)?.count, 3747)
                XCTAssertEqual(index.name, "index.html")
            } catch {
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
