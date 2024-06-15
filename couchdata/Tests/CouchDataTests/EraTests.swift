import Testing
@testable import CouchData

struct EraTests {
    
    // MARK: Value
    @Test func value() {
        #expect(Era(value: "1964-2020")?.value == "1964-2020")
        #expect(Era(value: "1980-1988, 2018-2020")?.value == "1980-1988, 2018-2020")
        #expect(Era(value: "1990-1991, 2017-")?.value == "1990-1991, 2017-")
        #expect(Era(value: "1990-1991, 2017")?.value == "1990-1991, 2017")
        #expect(Era(value: "2019-")?.value == "2019-")
        #expect(Era(value: "1968")?.value == "1968")
    }
    
    @Test func valueInit() {
        #expect(Era(value: "1964-2020")?.years == [1964...2020])
        #expect(Era(value: "1980-1988,2018-2020")?.years == [1980...1988, 2018...2020])
        #expect(Era(value: "1990-1991,2017-")?.years == [1990...1991, 2017...Int.max])
        #expect(Era(value: "1990-1991,2017")?.years == [1990...1991, 2017...2017])
        #expect(Era(value: "1968")?.years == [1968...1968])
        #expect(Era(value: "2019-")?.years == [2019...Int.max])
        #expect(Era(value: "1991-1990") == nil)
        #expect(Era(value: "") == nil)
    }
}
