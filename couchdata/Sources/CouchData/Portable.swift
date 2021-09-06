import SwiftUI
import UniformTypeIdentifiers

public typealias Portable = Importable & Exportable

public protocol Importable {
    
}

public protocol Exportable {
    static var contentType: UTType {
        get
    }
    
    static var defaultFilename: String? {
        get
    }
    
    var file: FileDocument? {
        get
    }
}
