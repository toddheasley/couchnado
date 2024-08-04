import Foundation

extension URLError: @retroactive CustomStringConvertible {
    
    // MARK: CustomStringConvertible
    public var description: String {
        !localizedDescription.contains(id) ? localizedDescription : "I'm sorry, Dave. I'm afraid I can't do that."
    }
}

extension URLError: @retroactive Identifiable {
    
    // MARK: Identifiable
    public var id: String { "\(code.rawValue)" }
}
