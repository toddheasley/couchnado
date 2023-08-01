import Foundation

extension URLError: CustomStringConvertible {
    
    // MARK: CustomStringConvertible
    public var description: String {
        guard !localizedDescription.contains("\(code.rawValue)") else {
            return "I'm sorry, Dave. I'm afraid I can't do that."
        }
        return localizedDescription
    }
}

extension URLError: Identifiable {
    
    // MARK: Identifiable
    public var id: String {
        return "\(code.rawValue)"
    }
}
