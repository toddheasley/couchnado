import Testing
@testable import CouchData
import Foundation

struct TableTests {
    @Test func records() throws {
        let table: Table = try #require(Table(data: TableTests_Data))
        #expect(table.records(Video.self).count == 3)
    }
    
    @Test func recordsInit() throws {
        let table1: Table = try #require(Table(data: TableTests_Data))
        let table2: Table = try #require(Table(records: table1.records(Video.self)))
        #expect([
            ["The Shining", "", "movie", "horror, suspense", "1980", "https://tv.apple.com/us/movie/the-shining/umc.cmc.be3gn94hs3l9fjvg34ex9sy1, https://en.wikipedia.org/wiki/The_Shining_(film)"],
            ["Castle Rock", "", "series", "horror, suspense", "2018-2019", "https://en.wikipedia.org/wiki/Castle_Rock_(TV_series)"],
            ["11.22.63", "", "miniseries", "science fiction", "2016", "https://en.wikipedia.org/wiki/11.22.63"]
        ] == table2.records)
        #expect(table1.schema == table2.schema)
    }
}

extension TableTests {
    @Test func data() throws {
        let table1: Table = try #require(Table(data: TableTests_Data))
        let table2: Table = try #require(Table(data: table1.data))
        #expect(table1.records == table2.records)
        #expect(table1.schema == table2.schema)
    }
    
    @Test func dataInit() throws {
        let table: Table = try #require(Table(data: TableTests_Data))
        #expect([
            ["The Shining", "", "movie", "horror, suspense", "1980, REDRUM", "https://tv.apple.com/us/movie/the-shining/umc.cmc.be3gn94hs3l9fjvg34ex9sy1, https://en.wikipedia.org/wiki/The_Shining_(film)"],
            ["Castle Rock", "", "series", "horror, suspense", "2018-2019", "https://en.wikipedia.org/wiki/Castle_Rock_(TV_series)"],
            ["11.22.63", "", "miniseries", "science fiction", "2016", "https://en.wikipedia.org/wiki/11.22.63,,"]
        ] == table.records)
        #expect(["Title", "Franchise", "Format", "Genres", "Era", "Links"] == table.schema)
    }
}

private let TableTests_Data: Data = """
Title\tFranchise\tFormat\tGenres\tEra\tLinks
The Shining\t\tmovie\thorror, suspense\t1980, REDRUM\thttps://tv.apple.com/us/movie/the-shining/umc.cmc.be3gn94hs3l9fjvg34ex9sy1, https://en.wikipedia.org/wiki/The_Shining_(film)
Castle Rock\t\tseries\thorror, suspense\t2018-2019\thttps://en.wikipedia.org/wiki/Castle_Rock_(TV_series)
11.22.63\t\tminiseries\tscience fiction\t2016\thttps://en.wikipedia.org/wiki/11.22.63,,
""".data(using: .utf8)!
