import Foundation
import CouchData

extension URL {
    public static let base: Self = try! base(relativeTo: docs)
    
    public static func base(_ name: String? = nil, relativeTo url: Self) throws -> Self {
        let name: String = try data(name, relativeTo: url).relativeString.components(separatedBy: ".")[0]
        let url: Self = try base(string: "\(name).html", relativeTo: url)
        return url
    }
    
    static func base(string: String, relativeTo url: Self = docs) throws -> Self {
        guard let string: String = string.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed), !string.isEmpty,
              let url: Self = Self(string: string, relativeTo: url) else {
            throw URLError(.badURL)
        }
        return url
    }
}
