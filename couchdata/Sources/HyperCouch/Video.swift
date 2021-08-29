import Foundation
import CouchData

extension Video {
    var filter: String {
        return [
            "\(title)".tokenized(),
            genres.map({ $0.tokenized() }).joined(separator: " "),
            "\(format)".tokenized()
        ].joined(separator: " ")
    }
    
    var subtitle: String {
        return "\(era) \(format)"
    }
    
    var watch: (url: URL, description: String)? {
        guard let url: URL = link(for: .apple) ?? link(for: .netflix) else {
            return nil
        }
        return (url, url.service?.description ?? url.host ?? "")
    }
    
    var about: (url: URL, description: String)? {
        guard let url: URL = link(for: .wikipedia) else {
            return nil
        }
        return (url, url.service?.description ?? url.host ?? "")
    }
}
