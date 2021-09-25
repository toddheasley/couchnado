import Foundation

extension String {
    mutating func replace(_ comment: Self, with value: Self) {
        self = replacing(comment, with: value)
    }
    
    func replacing(_ comment: Self, with value: Self) -> Self {
        return replacingOccurrences(of: "/* \(comment) */", with: value)
    }
    
    mutating func replace(_ tag: (Self, Self?), with value: Self) {
        self = replacing(tag, with: value)
    }
    
    func replacing(_ tag: (Self, Self?), with value: Self) -> Self {
        var string: Self = self
        for match in matches(tag) {
            string = string.replacingOccurrences(of: match, with: value)
        }
        return string
    }
    
    func values(for tag: (Self, Self)) -> [Self] {
        return matches(tag).map { $0.trimmed(tag) }
    }
    
    func matches(_ tag: (Self, Self?)) -> [Self] {
        var pattern: Self = "<!-- \(tag.0) -->".pattern()
        if !(tag.1 ?? "").isEmpty {
            pattern += "(.*?)\("<!-- \(tag.1!) -->".pattern())"
        }
        return matches(pattern)
    }
    
    func trimmed(_ tag: (Self, Self)) -> Self {
        var string: Self = self
        string = string.replacingOccurrences(of: "<!-- \(tag.0) -->", with: "")
        string = string.replacingOccurrences(of: "<!-- \(tag.1) -->", with: "")
        return string.hasPrefix("\n") ? Self(string.dropFirst(1)) : string
    }
}

extension String {
    func matches(_ pattern: Self) -> [Self] {
        guard let expression: NSRegularExpression = try? NSRegularExpression(pattern: pattern, options: .dotMatchesLineSeparators) else {
            return []
        }
        return expression.matches(in: self, options: [], range: NSRange(location: 0, length: utf8.count)).map { (self as NSString).substring(with: $0.range) }
    }
    
    func pattern(_ escape: [Character] = ["!", "?", "["]) -> Self {
        var pattern: Self = self
        for character in escape {
            pattern = pattern.replacingOccurrences(of: "\(character)", with: "\\\(character)")
        }
        return pattern
    }
}
