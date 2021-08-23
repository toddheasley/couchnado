import Foundation

struct Content: ExpressibleByStringLiteral, CustomStringConvertible {
    init(_ content: [Self] = [], indent: Bool = false) {
        description = content.description(indent)
    }
    
    init(_ tag: Tag) {
        description = tag.description
    }
    
    init(_ description: String) {
        self.description = description
    }
    
    // MARK: ExpressibleByStringLiteral
    typealias StringLiteralType = String
    
    init(stringLiteral value: StringLiteralType) {
        description = value
    }
    
    // MARK: CustomStringConvertible
    let description: String
}
