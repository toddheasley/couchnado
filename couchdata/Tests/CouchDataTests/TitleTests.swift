import Testing
@testable import CouchData

struct TitleTests {
    @Test func sortDescription() {
        #expect(Title(value: "A Fish Called Wanda")?.sortDescription ==  "Fish Called Wanda, A")
        #expect(Title(value: "The Empire Strikes Back")?.sortDescription == "Empire Strikes Back, The")
        #expect(Title(value: "Then There Were Three")?.sortDescription == "Then There Were Three")
        #expect(Title(value: "An American Tail")?.sortDescription == "American Tail, An")
        #expect(Title(value: "Anatomy of a Murder")?.sortDescription == "Anatomy of a Murder")
        #expect(Title(value: "2001: A Space Odyssey")?.sortDescription == "2001: A Space Odyssey")
        #expect(Title(value: "The A-Team")?.sortDescription == "A-Team, The")
    }
}
