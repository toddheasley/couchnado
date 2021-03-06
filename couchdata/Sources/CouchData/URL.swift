import Foundation

extension URL: Value {
    public enum Service: String, CaseIterable, CustomStringConvertible {
        case wikipedia = "Wikipedia"
        case apple = "Apple TV"
        case netflix = "Netflix"
        case disney = "Disney+"
        case amazon = "Prime Video"
        case hulu = "Hulu"
        case hbo = "HBO"
        
        fileprivate var host: String? {
            switch self {
            case .wikipedia:
                return "wikipedia.org"
            case .apple:
                return "apple.com"
            case .netflix:
                return "netflix.com"
            case .disney:
                return "disneyplus.com"
            case .amazon:
                return "amazon.com"
            case .hulu:
                return "hulu.com"
            case .hbo:
                return "hbo.com"
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
    
    // MARK: Value
    var value: String {
        return absoluteString
    }
    
    init?(value: String) {
        self.init(string: value)
    }
}
