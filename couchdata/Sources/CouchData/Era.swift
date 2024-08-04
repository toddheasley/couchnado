public struct Era: Sendable, ExpressibleByStringLiteral, CustomStringConvertible {
    public let years: [ClosedRange<Int>]
    
    init?(years: [ClosedRange<Int>]) {
        guard !years.isEmpty else {
            return nil
        }
        self.years = years
    }
    
    // MARK: ExpressibleByStringLiteral
    public init(stringLiteral value: String) {
        guard let era: Self = Self(value: value) else {
            fatalError()
        }
        self = era
    }
    
    // MARK: CustomStringConvertible
    public var description: String { value }
}

extension Era: Value {
    
    // MARK: Value
    var value: String {
        return years.map { year in
            if year.count == 1 {
                return "\(year.lowerBound)"
            } else if year.upperBound == .max {
                return "\(year.lowerBound)-"
            } else {
                return "\(year.lowerBound)-\(year.upperBound)"
            }
        }.joined(separator: ", ")
    }
    
    init?(value: String) {
        self.init(years: value.components(separatedBy: ",").compactMap { component in
            let component: String = component.filter("0123456789-".contains)
            let years: [Int] = component.components(separatedBy: "-").compactMap { year in
                return !year.isEmpty ? Int(year) : .max
            }
            guard let first: Int = years.first, first != .max,
                  let last: Int = years.last, first <= last else {
                return nil
            }
            return first...last
        })
    }
}

extension Era: Comparable {
    
    // MARK: Comparable
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.value < rhs.value
    }
}
