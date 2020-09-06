import SwiftUI
import UniformTypeIdentifiers

struct DocumentPicker {
    static func export(url: URL, result: @escaping (URL?) -> Void) {
        DocumentPickerView.shared = DocumentPickerView(forExporting: [url], asCopy: true)
        // DocumentPickerView.shared?.allowsMultipleSelection = false
        DocumentPickerView.shared?.present { urls in
            result(urls.first)
        }
    }
    
    static func `import`(types: [UTType], result: @escaping (URL?) -> Void) {
        DocumentPickerView.shared = DocumentPickerView(forOpeningContentTypes: types)
        DocumentPickerView.shared?.allowsMultipleSelection = false
        DocumentPickerView.shared?.present { urls in
            result(urls.first)
        }
    }
}

extension URL {
    static func document(at path: String = "") throws -> URL {
        return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(path)
    }
}

private class DocumentPickerView: UIDocumentPickerViewController, UIDocumentPickerDelegate {
    typealias Result = ([URL]) -> Void
    
    static var shared: DocumentPickerView?
    
    func present(_ result: @escaping Result) {
        self.delegate = self
        self.result = result
        UIApplication.shared.windows.first?.rootViewController?.present(self, animated: true)
    }
    
    private var result: Result?
        
    // MARK: UIDocumentPickerDelegate
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        delegate = nil
        result?(urls)
        result = nil
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        documentPicker(controller, didPickDocumentsAt: [])
    }
}
