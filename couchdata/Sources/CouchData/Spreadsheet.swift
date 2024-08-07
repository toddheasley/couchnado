#if os(macOS)
import SwiftUI
import UniformTypeIdentifiers

public struct Spreadsheet: Sendable, FileDocument {
    let table: Table
    
    init?(_ table: Table?) {
        guard let table: Table = table else {
            return nil
        }
        self.table = table
    }
    
    // MARK: FileDocument
    public static let readableContentTypes: [UTType] = [.tabSeparatedText]
    
    public init(configuration: ReadConfiguration) throws {
        guard let data: Data = configuration.file.regularFileContents,
              let table: Table = Table(data: data) else {
            throw URLError(.cannotDecodeContentData)
        }
        self.table = table
    }
    
    public func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        FileWrapper(regularFileWithContents: table.data)
    }
}
#endif
