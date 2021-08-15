import XCTest
@testable import CouchData

final class CouchDataTests: XCTestCase {
    func testSave() {
        let expectation: XCTestExpectation = XCTestExpectation()
        let data: CouchData = CouchData(Bundle.module.url(forResource: "index", withExtension: "tsv")!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            do {
                let url: URL = try .data("index", relativeTo: URL(fileURLWithPath: NSTemporaryDirectory()))
                try data.save(url)
                let file: Data = try Data(contentsOf: url)
                XCTAssertEqual(Table(data: file)?.records.count, 6)
                XCTAssertEqual(file.count, 1461)
            } catch {
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
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
