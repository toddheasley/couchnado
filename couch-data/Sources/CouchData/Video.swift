import Foundation

public struct Video: Record, Comparable, CustomStringConvertible {
    public enum Format: String, Value, Codable, CaseIterable, CustomStringConvertible {
        case movie, miniseries, series
        
        // MARK: Value
        var label: String {
            return "Format"
        }
        
        // MARK: CustomStringConvertible
        public var description: String {
            return value
        }
    }
    
    public let title: Title
    public let format: Format
    public let genres: [Genre]
    public let circa: Circa
    public let links: [URL]
    
    // MARK: Record
    let schema: [String] = ["Title", "Format", "Genres", "Circa", "Links"]
    
    var record: [String] {
        return [title.value, format.value, genres.value, circa.value, links.value]
    }
    
    init?(record: [String]) {
        guard record.count == schema.count,
              let title: Title = Title(value: record[0]),
              let format: Format = Format(value: record[1]),
              let genres: [Genre] = Array(value: record[2]),
              let circa: Circa = Circa(value: record[3]),
              let links: [URL] = Array(value: record[4]) else {
            return nil
        }
        self.title = title
        self.format = format
        self.genres = genres
        self.circa = circa
        self.links = links
    }
    
    // MARK: Comparable
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.title < rhs.title
    }
    
    // MARK: CustomStringConvertible
    public var description: String {
        return "\(title) (\(circa) \(format))"
    }
}
