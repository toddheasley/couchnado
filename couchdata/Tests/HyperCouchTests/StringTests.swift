import Testing
@testable import HyperCouch

struct StringTests {
    @Test func commentReplace() {
        var string: String = "--background: /* background-dark */;"
        string.replace("background-dark", with: "rgb(0, 0, 0)")
        #expect(string == "--background: rgb(0, 0, 0);")
    }
    
    @Test func commentReplacing() {
        #expect("--background: /* background-dark */;".replacing("background-dark", with: "rgb(0, 0, 0)") == "--background: rgb(0, 0, 0);")
    }
    
    @Test func tagReplace() {
        var string: String = "<title><!-- title --></title>"
        string.replace(("title", nil), with: "HyperCouch")
        #expect(string == "<title>HyperCouch</title>")
        string = "<!-- genres? -->\n<!-- genres[ -->\n    <option><!-- genre --></option>\n<!-- ]genres -->\n    <option>&nbsp;</option>\n<!-- ?genres -->"
        string.replace(("genres?", "?genres"), with: "")
        #expect(string == "")
    }
    
    @Test func tagReplacing() {
        #expect("<title><!-- title --></title>".replacing(("title", nil), with: "HyperCouch") == "<title>HyperCouch</title>")
        #expect("<!-- genres? -->\n<!-- genres[ -->\n    <option><!-- genre --></option>\n<!-- ]genres -->\n    <option>&nbsp;</option>\n<!-- ?genres -->".replacing(("genres?", "?genres"), with: "") == "")
    }
    
    @Test func tagValues() {
        #expect(string.values(for: ("genres[", "]genres")) == ["    <option><!-- genre --></option>\n"])
    }
    
    @Test func tagMatches() {
        #expect(string.matches(("title", nil)) == ["<!-- title -->", "<!-- title -->"])
        #expect(string.matches(("genres?", "?genres")) == ["<!-- genres? -->\n<!-- genres[ -->\n    <option><!-- genre --></option>\n<!-- ]genres -->\n    <option>&nbsp;</option>\n<!-- ?genres -->"])
        #expect(string.matches(("format[", "]format")) == ["<!-- format[ -->\n    <option><!-- format --></option>\n<!-- ]format -->"])
    }
    
    @Test func tagTrimmed() {
        #expect("<!-- genres[ -->\n    <option><!-- genre --></option>\n<!-- ]genres -->".trimmed(("genres[", "]genres")) == "    <option><!-- genre --></option>\n")
    }
}

extension StringTests {
    @Test func patternMatches() {
        #expect(string.matches("<!-- title -->") == ["<!-- title -->", "<!-- title -->"])
        #expect(string.matches("<\\!-- genres\\[ -->(.*?)<!-- ]genres -->") == ["<!-- genres[ -->\n    <option><!-- genre --></option>\n<!-- ]genres -->"])
        #expect(string.matches("<option>(.*?)</option>") == ["<option><!-- genre --></option>", "<option>&nbsp;</option>", "<option><!-- format --></option>"])
    }
    
    @Test func pattern() {
        #expect("<!-- videos? -->".pattern(["!"]) == "<\\!-- videos? -->")
        #expect("<!-- videos? -->".pattern() == "<\\!-- videos\\? -->")
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
