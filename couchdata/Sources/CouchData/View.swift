#if os(macOS)
import SwiftUI

extension View {
    public func spreadsheet(_ data: CouchData, isImporting: Binding<Bool>) -> some View {
        return fileImporter(isPresented: isImporting, allowedContentTypes: [CouchData.contentType]) { result in
            switch result {
            case.success(let url):
                Task {
                    await data.load(url)
                }
            case .failure(let error):
                data.error = error as? URLError ?? URLError(.cannotOpenFile)
            }
        }
    }
    
    public func spreadsheet(_ data: CouchData, isExporting: Binding<Bool>) -> some View {
        return fileExporter(isPresented: isExporting, document: data.file as? Spreadsheet, contentType: CouchData.contentType, defaultFilename: CouchData.defaultFilename) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                data.error = error as? URLError ?? URLError(.cannotWriteToFile)
            }
        }
    }
}
#endif
