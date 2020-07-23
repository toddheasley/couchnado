import Foundation

public struct Title: Value, Comparable, CustomStringConvertible {
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
    
    // MARK: Value
    let value: String
    
    init?(value: String) {
        guard !value.isEmpty else {
            return nil
        }
        self.value = value
    }
    
    // MARK: Comparable
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.sortDescription < rhs.sortDescription
    }
    
    // MARK: CustomStringConvertible
    public var description: String {
        return value
    }
}
