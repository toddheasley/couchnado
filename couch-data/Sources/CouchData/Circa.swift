import Foundation

public struct Circa: Value, Comparable, CustomStringConvertible {
    public let years: [ClosedRange<Int>]
    
    init?(years: [ClosedRange<Int>]) {
        guard !years.isEmpty else {
            return nil
        }
        self.years = years
    }
    
    // MARK: Value
    var value: String {
        return years.map { year in
            switch year.count {
            case 1:
                return "\(year.lowerBound)"
            default:
                return "\(year.lowerBound)-\(year.upperBound)"
            }
        }.joined(separator: ", ")
    }
    
    init?(value: String) {
        self.init(years: value.components(separatedBy: ",").compactMap { component in
            let years: [Int] = component.components(separatedBy: "-").compactMap { year in
                return Int(year.trimmingCharacters(in: .whitespaces))
            }
            guard let first: Int = years.first,
                  let last: Int = years.last, first <= last else {
                return nil
            }
            return first...last
        })
    }
    
    // MARK: Comparable
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.value < rhs.value
    }
    
    // MARK: CustomStringConvertible
    public var description: String {
        return value
    }
}
