public struct Title: Value, Sendable, ExpressibleByStringLiteral, CustomStringConvertible {
    public var sortDescription: String {
        var components: [String] = value.components(separatedBy: " ")
        if components.count > 1, ["a", "an", "the"].contains(components[0].lowercased()) {
            let component: String = components[0]
            components.remove(at: 0)
            components[components.count - 1] += ","
            components.append(component)
        }
        return components.joined(separator: " ")
    }
    
    func matches(_ string: String) -> Bool {
        string.isEmpty || description.tokenized().contains(string.tokenized())
    }
    
    // MARK: Value
    let value: String
    
    init?(value: String) {
        guard !value.isEmpty else {
            return nil
        }
        self.value = value
    }
    
    // MARK: ExpressibleByStringLiteral
    public init(stringLiteral value: String) {
        self.value = value
    }
    
    // MARK: CustomStringConvertible
    public var description: String { value }
}

extension Title: Comparable {
    
    // MARK: Comparable
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.sortDescription.lowercased() < rhs.sortDescription.lowercased()
    }
}
