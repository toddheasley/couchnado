import Foundation

extension String {
    var unwrappedValue: String {
        return self.replacingOccurrences(of: "\"=\"\"", with: "").replacingOccurrences(of: "\"\"\"", with: "")
    }
    
    var wrappedValue: String {
        return "\"=\"\"\(self)\"\"\""
    }
    
    func tokenized() -> String {
        return value.replacingOccurrences(of: " ", with: "")
    }
}

extension String: Value {
    
    // MARK: Value
    var value: String {
        return lowercased().filter("0123456789 abcdefghijklmnopqrstuvwxyz".contains).trimmingCharacters(in: .whitespaces)
    }
    
    init?(value: String) {
        let value: String = value.value
        guard !value.isEmpty else {
            return nil
        }
        self = value
    }
}
