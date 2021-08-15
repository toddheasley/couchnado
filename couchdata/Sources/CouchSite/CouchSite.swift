import Foundation
import CouchData

public struct CouchSite {
    public let data: CouchData
    
    public func save(_ url: URL) throws {
        throw URLError(.unknown)
    }
    
    public init(_ data: CouchData) {
        self.data = data
    }
}
