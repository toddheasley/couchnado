extension String {
    public func tokenized() -> String {
        value.replacingOccurrences(of: " ", with: "")
    }
    
    var unwrappedValue: String { replacingOccurrences(of: "\"=\"\"", with: "").replacingOccurrences(of: "\"\"\"", with: "") }
    
    var wrappedValue: String { "\"=\"\"\(self)\"\"\"" }
}

extension String: Value {
    
    // MARK: Value
    var value: String { lowercased().filter("0123456789 abcdefghijklmnopqrstuvwxyz".contains).trimmingCharacters(in: .whitespaces) }
    
    init?(value: String) {
        let value: String = value.value
        guard !value.isEmpty else {
            return nil
        }
        self = value
    }
}

extension String: @retroactive Identifiable {
    
    // MARK: Identifiable
    public var id: Self { self }
}
