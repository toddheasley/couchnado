import Foundation

extension URL {
    public static let repo: Self = Self(string: "https://github.com/toddheasley/couchnado")!
    public static let docs: Self = Self(string: "https://toddheasley.github.io/couchnado/")!
    public static let data: Self = try! data("index", relativeTo: docs)
    
    public static func data(_ name: String, relativeTo url: Self) throws -> Self {
        switch url.scheme {
        case "https", "http", "file":
            guard let name: String = name.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed), !name.isEmpty,
                  let table: Self = Self(string: "\(name).tsv", relativeTo: url) else {
                throw URLError(.badURL)
            }
            return table
        default:
            throw URLError(.unsupportedURL)
        }
    }
}

extension URL {
    public enum Service: String, CaseIterable, CustomStringConvertible {
        case wikipedia = "Wikipedia"
        case apple = "Apple TV"
        case netflix = "Netflix"
        
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
        
        // MARK: CustomStringConvertible
        public var description: String {
            return rawValue
        }
    }
    
    public var service: Service? {
        return Service.allCases.filter({ service in
            return (host ?? "").contains(service.host ?? " ")
        }).first
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
