import Foundation

struct Attribute: CustomStringConvertible {
    static func `class`(_ value: String?) -> Self {
        return value != nil ? Self("class", value: value) : Self()
    }
    
    static func title(_ value: String?) -> Self {
        return value != nil ? Self("title", value: value) : Self()
    }
    
    static func href(_ value: URL) -> Self {
        return Self("href", value: value.absoluteString)
    }
    
    let name: String
    let value: String?
    
    init(_ name: String = "", value: String? = nil) {
        self.name = name
        self.value = !name.isEmpty ? value : nil
    }
    
    // MARK: CustomStringConvertible
    var description: String {
        var description: String = ""
        if !name.isEmpty {
            description += "\(name)"
            if let value: String = value {
                description += "=\"\(value)\""
            }
        }
        return description
    }
}
