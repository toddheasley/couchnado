import SwiftUI
import UniformTypeIdentifiers
import CouchData

public struct HyperCouch {
    public let data: CouchData
    public let title: String
    
    public init(_ data: CouchData, title: String = "HyperCouch") {
        self.data = data
        self.title = title
    }
}

#if !os(tvOS)
extension HyperCouch: Exportable {
    
    // MARK: Exportable
    public static let contentType: UTType = WebPage.readableContentTypes.first!
    public static let defaultFilename: String? = URL.base.deletingPathExtension().relativeString
    
    public var file: FileDocument? {
        return try? WebPage(data, title: title)
    }
}
#endif
