import XCTest
@testable import CouchData

final class TitleTests: XCTestCase {
    func testSortDescription() {
        XCTAssertEqual(Title(value: "A Fish Called Wanda")?.sortDescription, "Fish Called Wanda, A")
        XCTAssertEqual(Title(value: "The Empire Strikes Back")?.sortDescription, "Empire Strikes Back, The")
        XCTAssertEqual(Title(value: "Then There Were Three")?.sortDescription, "Then There Were Three")
        XCTAssertEqual(Title(value: "An American Tail")?.sortDescription, "American Tail, An")
        XCTAssertEqual(Title(value: "Anatomy of a Murder")?.sortDescription, "Anatomy of a Murder")
        XCTAssertEqual(Title(value: "2001: A Space Odyssey")?.sortDescription, "2001: A Space Odyssey")
        XCTAssertEqual(Title(value: "The A-Team")?.sortDescription, "A-Team, The")
    }
}
