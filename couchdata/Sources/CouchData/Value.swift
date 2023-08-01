import Foundation

protocol Value {
    var value: String {
        get
    }
    
    init?(value: String)
}

extension Value where Self: RawRepresentable, Self.RawValue == String {
    
    // MARK: Value
    var value: String {
        return rawValue
    }
    
    init?(value: String) {
        self.init(rawValue: value)
    }
}
