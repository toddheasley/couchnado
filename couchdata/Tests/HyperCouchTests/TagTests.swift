import XCTest
@testable import HyperCouch

final class TagTests: XCTestCase {
    func testBlockInit() {
        XCTAssertEqual(Tag("article", attributes: [.title("Article")], block: ["<p></p>"]).description, "<article title=\"Article\">\n    <p></p>\n</article>")
        XCTAssertEqual(Tag("article", block: [""]).description, "<article>\n    \n</article>")
    }
    
    func testInlineInit() {
        XCTAssertEqual(Tag("a", attributes: [.href(URL(string: "https://netflix.com")!), .title("Link")], inline: "Netflix").description, "<a href=\"https://netflix.com\" title=\"Link\">Netflix</a>")
        XCTAssertEqual(Tag("", attributes: [.href(URL(string: "https://netflix.com")!)], inline: "Netflix").description, "")
        XCTAssertEqual(Tag("script", inline: "").description, "<script></script>")
        XCTAssertEqual(Tag("br").description, "<br>")
    }
}
