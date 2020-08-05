import Foundation

struct Table {
    let records: [[String]]
    let schema: [String]
    
    func records<T: Record>(_ type: T.Type) -> [T] {
        return records.compactMap { T(record: $0) }
    }
    
    init?(records: [Record]) {
        guard let schema: [String] = records.first?.schema else {
            return nil
        }
        self.records = records.compactMap { record in
            return record.schema == schema ? record.record : nil
        }
        self.schema = schema
    }
}

extension Table {
    var data: Data {
        var components: [String] = [schema.joined(separator: "\t")]
        for record in records {
            components.append(record.map { $0.wrapped }.joined(separator: "\t"))
        }
        return components.joined(separator: "\n").data(using: .utf8)!
    }
    
    init?(data: Data) {
        guard let components: [String] = String(data: data, encoding: .utf8)?.components(separatedBy: "\n"),
            let schema: [String] = components.first?.components(separatedBy: "\t"), !schema.isEmpty else {
            return nil
        }
        self.schema = schema
        self.records = components.compactMap { component in
            let record: [String] = component.components(separatedBy: "\t").map { $0.unwrapped }
            return record.count == schema.count && record != schema ? record : nil
        }
    }
}

extension String {
    fileprivate var wrapped: String {
        return "\"=\"\"\(self)\"\"\""
    }
    
    fileprivate var unwrapped: String {
        return self.replacingOccurrences(of: "\"=\"\"", with: "").replacingOccurrences(of: "\"\"\"", with: "")
    }
}

protocol Record {
    var schema: [String] {
        get
    }
    
    var record: [String] {
        get
    }
    
    init?(record: [String])
}

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

extension Array: Value where Element: Value {
    
    // MARK: Value
    var value: String {
        return map { $0.value }.joined(separator: ", ")
    }
    
    init?(value: String) {
        self = value.components(separatedBy: ",").compactMap { Element(value: $0.trimmingCharacters(in: .whitespacesAndNewlines))}
    }
}
