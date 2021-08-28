import Foundation
import CouchData

public struct HyperCouch {
    public let data: CouchData
    public let title: String
    
    @discardableResult public func save(_ url: URL) throws -> URL {
        try Resource("apple-touch-icon.png").save(url)
        try Resource("favicon.ico").save(url)
        try Resource("image.png").save(url)
        return try Index(data, title: title).save(url)
    }
    
    public init(_ data: CouchData, title: String = "HyperCouch") {
        self.data = data
        self.title = title
    }
}
