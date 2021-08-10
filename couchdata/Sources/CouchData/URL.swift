import Foundation

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
