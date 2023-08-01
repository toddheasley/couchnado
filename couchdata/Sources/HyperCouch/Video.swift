import Foundation
import CouchData

extension Video {
    public var subtitle: String {
        return "\(era) \(format)"
    }
    
    public var watch: URL? {
        return link(for: .apple) ?? link(for: .netflix)
    }
    
    public var about: URL? {
#if canImport(WebKit)
        return link(for: .wikipedia)
#else
        return nil
#endif
    }
    
    var filter: String {
        return [
            "\(title)".tokenized(),
            genres.map({ $0.tokenized() }).joined(separator: " "),
            "\(format)".tokenized()
        ].joined(separator: " ")
    }
}
