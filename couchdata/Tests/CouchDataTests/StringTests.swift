import Testing
@testable import CouchData

struct StringTests {
    
    // MARK: Value
    @Test func value() {
        #expect(" Science Fiction \n".value == "science fiction")
    }
    
    @Test func valueInit() {
        #expect(String(value: "\nScience fiction") == "science fiction")
        #expect(String(value: " ") == nil)
        #expect(String(value: "") == nil)
    }
}
