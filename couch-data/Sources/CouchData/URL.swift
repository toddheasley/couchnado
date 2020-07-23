import Foundation

extension URL: Value {
    public enum Service: String, CaseIterable, CustomStringConvertible {
        case apple = "Apple TV"
        case hbo = "HBO"
        case hulu = "Hulu"
        case netflix = "Netflix"
        case prime = "Prime"
        case showtime = "Showtime"
        case wikipedia = "Wikipedia"
        
        fileprivate var host: String? {
            switch self {
            case .apple:
                return "apple.com"
            case .hulu:
                return "hulu.com"
            case .netflix:
                return "netflix.com"
            case .prime:
                return "amazon.com"
            case .wikipedia:
                return "wikipedia.org"
            default:
                return nil
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
