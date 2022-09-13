import XCTest
import CouchData
@testable import HyperCouch

final class WebPageTests: XCTestCase {
    func testInit() {
        let expectation: XCTestExpectation = XCTestExpectation()
        let data: CouchData = CouchData(Bundle.module.url(forResource: "index", withExtension: "tsv")!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            do {
                let page: WebPage = try WebPage(data, title: "Couchnado")
#if os(macOS) || os(iOS)
                XCTAssertEqual(page.description.count, 5492)
#elseif os(tvOS)
                XCTAssertEqual(page.description.count, 5113)
#endif
                XCTAssertEqual(page.resources.count, 5)
            } catch {
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
