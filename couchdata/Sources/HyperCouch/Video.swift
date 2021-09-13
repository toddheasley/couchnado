import Foundation
import CouchData

extension Video {
    public var subtitle: String {
        return "\(era) \(format)"
    }
    
    public var watch: (url: URL, description: String)? {
        guard let url: URL = link(for: .apple) ?? link(for: .netflix) else {
            return nil
        }
        return (url, url.service?.description ?? url.host ?? "")
    }
    
    public var about: (url: URL, description: String)? {
#if !os(tvOS)
        if let url: URL = link(for: .wikipedia) {
            return (url, url.service?.description ?? url.host ?? "")
        }
#endif
        return nil
    }
    
    var filter: String {
        return [
            "\(title)".tokenized(),
            genres.map({ $0.tokenized() }).joined(separator: " "),
            "\(format)".tokenized()
        ].joined(separator: " ")
    }
}
