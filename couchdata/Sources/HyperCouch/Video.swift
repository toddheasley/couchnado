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
    
    var watch: URL? {
        return links.filter { [URL.Service.apple, .netflix].contains($0.service) }.first
    }
    
    var about: URL? {
        return link(for: .wikipedia)
    }
}
