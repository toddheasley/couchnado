import Foundation

extension Array where Element == Content {
    func description(_ indent: Bool = false) -> String {
        var description: String = map { "\($0)" }.joined(separator: "\n")
        if indent {
            description = "    \(description.replacingOccurrences(of: "\n", with: "\n    "))"
        }
        return description
    }
}
