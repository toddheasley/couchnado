import XCTest
@testable import CouchData

final class TableTests: XCTestCase {
    func testRecords() throws {
        let table: Table = try XCTUnwrap(Table(data: TableTests_Data))
        XCTAssertEqual(table.records(Video.self).count, 3)
    }
    
    func testRecordsInit() throws {
        let table1: Table = try XCTUnwrap(Table(data: TableTests_Data))
        let table2: Table = try XCTUnwrap(Table(records: table1.records(Video.self)))
        
        XCTAssertEqual(table1.schema, table2.schema)
        XCTAssertEqual([
            ["The Shining", "movie", "horror, thriller", "1980", "https://tv.apple.com/us/movie/the-shining/umc.cmc.be3gn94hs3l9fjvg34ex9sy1, https://en.wikipedia.org/wiki/The_Shining_(film)"],
            ["Castle Rock", "series", "horror, thriller", "2018-2019", "https://en.wikipedia.org/wiki/Castle_Rock_(TV_series)"],
            ["11.22.63", "miniseries", "science fiction, history", "2016", "https://en.wikipedia.org/wiki/11.22.63"]
        ], table2.records)
    }
}

extension TableTests {
    func testData() throws {
        let table1: Table = try XCTUnwrap(Table(data: TableTests_Data))
        let table2: Table = try XCTUnwrap(Table(data: table1.data))
        XCTAssertEqual(table1.schema, table2.schema)
        XCTAssertEqual(table1.records, table2.records)
    }
    
    func testDataInit() throws {
        let table: Table = try XCTUnwrap(Table(data: TableTests_Data))
        XCTAssertEqual(table.schema, ["Title", "Format", "Genres", "Era", "Links"])
        XCTAssertEqual(table.records, [
            ["The Shining", "movie", "horror, thriller", "1980, REDRUM", "https://tv.apple.com/us/movie/the-shining/umc.cmc.be3gn94hs3l9fjvg34ex9sy1, https://en.wikipedia.org/wiki/The_Shining_(film)"],
            ["Castle Rock", "series", "horror, movie, thriller", "2018-2019", "https://en.wikipedia.org/wiki/Castle_Rock_(TV_series)"],
            ["11.22.63", "miniseries", "science fiction, history", "2016", "https://en.wikipedia.org/wiki/11.22.63,,"]
        ])
    }
}

private let TableTests_Data: Data = """
Title\tFormat\tGenres\tEra\tLinks
The Shining\tmovie\thorror, thriller\t1980, REDRUM\thttps://tv.apple.com/us/movie/the-shining/umc.cmc.be3gn94hs3l9fjvg34ex9sy1, https://en.wikipedia.org/wiki/The_Shining_(film)
Castle Rock\tseries\thorror, movie, thriller\t2018-2019\thttps://en.wikipedia.org/wiki/Castle_Rock_(TV_series)
11.22.63\tminiseries\tscience fiction, history\t2016\thttps://en.wikipedia.org/wiki/11.22.63,,
""".data(using: .utf8)!
