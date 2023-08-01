import Foundation

public struct Video: Record, Identifiable, Comparable, CustomStringConvertible {
    public enum Format: String, Value, CaseIterable, Identifiable, CustomStringConvertible {
        case movie, miniseries, series
        
        // MARK: Identifiable
        public var id: String {
            return value
        }
        
        // MARK: CustomStringConvertible
        public var description: String {
            return value
        }
    }
    
    public enum Filter: Equatable, CustomStringConvertible {
        case title(String), genre(String), format(Format), none
        
        // MARK: CustomStringConvertible
        public var description: String {
            switch self {
            case .title(let title):
                return "filtered by title \"\(title)\""
            case .genre(let genre):
                return "filtered by genre \"\(genre)\""
            case .format(let format):
                return "filtered by format \"\(format)\""
            case .none:
                return ""
            }
        }
    }

    public enum Sort: String, CustomStringConvertible {
        case title, era
        
        public static let `default`: Self = .title
        
        // MARK: CustomStringConvertible
        public var description: String {
            return rawValue
        }
    }
    
    public let title: Title
    public let franchise: Title?
    public let format: Format
    public let genres: [String]
    public let era: Era
    public let links: [URL]
    
    public func link(for service: URL.Service) -> URL? {
        return links.compactMap({ $0.service == service ? $0 : nil }).first
    }
    
    func matches(_ string: String) -> Bool {
        return (franchise?.matches(string) ?? false) || title.matches(string)
    }
    
    public init(_ title: Title, franchise: Title? = nil, format: Format, genres: [String] = [], era: Era, links: [URL] = []) {
        self.title = title
        self.franchise = franchise
        self.format = format
        self.genres = genres
        self.era = era
        self.links = links
    }
    
    // MARK: Record
    let schema: [String] = ["Title", "Franchise", "Format", "Genres", "Era", "Links"]
    
    var record: [String] {
        return [title.value, franchise?.value ?? "", format.value, genres.value, era.value, links.value]
    }
    
    init?(record: [String]) {
        guard record.count == schema.count,
              let title: Title = Title(value: record[0]),
              let format: Format = Format(value: record[2]),
              let genres: [String] = Array(value: record[3]),
              let era: Era = Era(value: record[4]),
              let links: [URL] = Array(value: record[5]) else {
            return nil
        }
        self.title = title
        self.franchise = Title(value: record[1])
        self.format = format
        self.genres = genres
        self.era = era
        self.links = links
    }
    
    // MARK: Identifiable
    public var id: String {
        return description.lowercased()
    }
        
    // MARK: Comparable
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.title < rhs.title
    }
    
    // MARK: CustomStringConvertible
    public var description: String {
        return "\(title) (\(era) \(format))"
    }
}
