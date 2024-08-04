import Foundation

struct Table: Sendable {
    let records: [[String]]
    let schema: [String]
    
    func records<T: Record>(_ type: T.Type) -> [T] {
        records.compactMap { T(record: $0) }
    }
    
    init?(records: [Record]) {
        guard let schema: [String] = records.first?.schema else {
            return nil
        }
        self.records = records.compactMap { $0.schema == schema ? $0.record : nil }
        self.schema = schema
    }
}

extension Table {
    var data: Data {
        var components: [String] = [schema.joined(separator: "\t")]
        for record in records {
            components.append(record.map { $0.wrappedValue }.joined(separator: "\t"))
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
            let record: [String] = component.components(separatedBy: "\t").map { $0.unwrappedValue }
            return record.count == schema.count && record != schema ? record : nil
        }
    }
}
