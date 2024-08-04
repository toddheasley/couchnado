import Foundation
import CouchData

extension Video {
    public var subtitle: String { "\(era) \(format)" }
    
    public var watch: URL? { link(for: .apple) ?? link(for: .netflix) }
    
    public var about: URL? {
#if canImport(WebKit)
        link(for: .wikipedia)
#else
        nil
#endif
    }
    
    var filter: String {
        [
            "\(title)".tokenized(),
            genres.map({ $0.tokenized() }).joined(separator: " "),
            "\(format)".tokenized()
        ].joined(separator: " ")
    }
}
