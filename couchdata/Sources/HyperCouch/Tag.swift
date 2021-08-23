import Foundation

struct Tag: CustomStringConvertible {
    init(_ name: String, attributes: [Attribute] = [], block content: [Content]) {
        self.init(name, attributes: attributes, inline: Content(["", Content(content, indent: true), ""]))
    }
    
    init(_ name: String, attributes: [Attribute] = [], inline content: Content? = nil) {
        var description: String = ""
        if !name.isEmpty {
            description += "<\(name)\(attributes.map { " \($0)" }.joined())>"
            if let content: Content = content {
                description += "\(content)</\(name)>"
            }
        }
        self.description = description
    }
    
    // MARK: CustomStringConvertible
    let description: String
}
