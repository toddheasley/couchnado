import XCTest
@testable import HyperCouch

final class StringTests: XCTestCase {
    
}

extension StringTests {
    func testCommentReplace() {
        var string: String = "--background: /* background-dark */;"
        string.replace("background-dark", with: "rgb(0, 0, 0)")
        XCTAssertEqual(string, "--background: rgb(0, 0, 0);")
    }
    
    func testCommentReplacing() {
        XCTAssertEqual("--background: /* background-dark */;".replacing("background-dark", with: "rgb(0, 0, 0)"), "--background: rgb(0, 0, 0);")
    }
    
    func testTagReplace() {
        var string: String = "<title><!-- title --></title>"
        string.replace(("title", nil), with: "HyperCouch")
        XCTAssertEqual(string, "<title>HyperCouch</title>")
        string = "<!-- genres? -->\n<!-- genres[ -->\n    <option><!-- genre --></option>\n<!-- ]genres -->\n    <option>&nbsp;</option>\n<!-- ?genres -->"
        string.replace(("genres?", "?genres"), with: "")
        XCTAssertEqual(string, "")
        
    }
    
    func testTagReplacing() {
        XCTAssertEqual("<title><!-- title --></title>".replacing(("title", nil), with: "HyperCouch"), "<title>HyperCouch</title>")
        XCTAssertEqual("<!-- genres? -->\n<!-- genres[ -->\n    <option><!-- genre --></option>\n<!-- ]genres -->\n    <option>&nbsp;</option>\n<!-- ?genres -->".replacing(("genres?", "?genres"), with: ""), "")
    }
    
    func testTagValues() {
        XCTAssertEqual(string.values(for: ("genres[", "]genres")), ["    <option><!-- genre --></option>\n"])
    }
    
    func testTagMatches() {
        XCTAssertEqual(string.matches(("title", nil)), ["<!-- title -->", "<!-- title -->"])
        XCTAssertEqual(string.matches(("genres?", "?genres")), ["<!-- genres? -->\n<!-- genres[ -->\n    <option><!-- genre --></option>\n<!-- ]genres -->\n    <option>&nbsp;</option>\n<!-- ?genres -->"])
        XCTAssertEqual(string.matches(("format[", "]format")), ["<!-- format[ -->\n    <option><!-- format --></option>\n<!-- ]format -->"])
    }
    
    func testTagTrimmed() {
        XCTAssertEqual("<!-- genres[ -->\n    <option><!-- genre --></option>\n<!-- ]genres -->".trimmed(("genres[", "]genres")), "    <option><!-- genre --></option>\n")
    }
}

extension StringTests {
    func testPatternMatches() {
        XCTAssertEqual(string.matches("<!-- title -->"), ["<!-- title -->", "<!-- title -->"])
        XCTAssertEqual(string.matches("<\\!-- genres\\[ -->(.*?)<!-- ]genres -->"), ["<!-- genres[ -->\n    <option><!-- genre --></option>\n<!-- ]genres -->"])
        XCTAssertEqual(string.matches("<option>(.*?)</option>"), ["<option><!-- genre --></option>", "<option>&nbsp;</option>", "<option><!-- format --></option>"])
    }
    
    func testPattern() {
        XCTAssertEqual("<!-- videos? -->".pattern(["!"]), "<\\!-- videos? -->")
        XCTAssertEqual("<!-- videos? -->".pattern(), "<\\!-- videos\\? -->")
    }
}

private let string: String = """
<!DOCTYPE html>
<title><!-- title --></title>
<meta name="og:title" content="<!-- title -->">
<datalist id="filter">
<!-- genres? -->
<!-- genres[ -->
    <option><!-- genre --></option>
<!-- ]genres -->
    <option>&nbsp;</option>
<!-- ?genres -->
<!-- format[ -->
    <option><!-- format --></option>
<!-- ]format -->
</datalist>
"""
