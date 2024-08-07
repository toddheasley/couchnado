import Foundation

extension URL {
    public static let repo: Self = Self(string: "https://github.com/toddheasley/couchnado")!
    public static let docs: Self = Self(string: "https://toddheasley.github.io/couchnado/")!
    public static let data: Self = try! data(relativeTo: docs)
    
    public static func data(_ name: String? = nil, relativeTo url: Self) throws -> Self {
        switch url.scheme {
        case "https", "http", "file":
            guard let name: String = (name ?? "index").addingPercentEncoding(withAllowedCharacters: .urlPathAllowed), !name.isEmpty,
                  let url: Self = Self(string: "\(name).tsv", relativeTo: url) else {
                throw URLError(.badURL)
            }
            return url
        default:
            throw URLError(.unsupportedURL)
        }
    }
}

extension URL {
    public enum Service: String, Sendable, CaseIterable, Identifiable, CustomStringConvertible {
        case wikipedia, apple, netflix
        
        fileprivate var host: String? {
            switch self {
            case .wikipedia:
                return "wikipedia.org"
            case .apple:
                return "apple.com"
            case .netflix:
                return "netflix.com"
            }
        }
        
        // MARK: Identifiable
        public var id: String { rawValue }
        
        // MARK: CustomStringConvertible
        public var description: String {
            switch self {
            case .apple:
                return "Apple TV"
            default:
                return rawValue.capitalized
            }
        }
    }
    
    public var service: Service? {
        Service.allCases.filter { (host ?? "").contains($0.host ?? " ") }.first
    }
}

extension URL: Value {
    
    // MARK: Value
    var value: String {
        return absoluteString
    }
    
    init?(value: String) {
        self.init(string: value)
    }
}
