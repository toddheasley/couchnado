import SwiftUI
import CouchData

extension WindowGroup {
    func commands(data: CouchData) -> some Scene {
        #if os(iOS)
        #if targetEnvironment(macCatalyst)
        for scene in UIApplication.shared.connectedScenes {
            (scene as? UIWindowScene)?.titlebar?.titleVisibility = .hidden
        }
        #endif
        return commands {
            CommandGroup(replacing: .help) {
                Button("Couchnado Documentation and Source Code") {
                    Safari.open(url: URL(string: "https://github.com/toddheasley/couchnado")!)
                }
            }
            CommandGroup(after: .newItem) {
                Button("Import \(CouchData.FileFormat.tsv)…".capitalized) {
                    importData(data)
                }
                .keyboardShortcut("o", modifiers: [.command, .shift])
                Divider()
                Button("Export \(CouchData.FileFormat.tsv)…".capitalized) {
                    exportData(data, format: .tsv)
                }
                .keyboardShortcut("e", modifiers: [.command, .shift])
                Button("Export \(CouchData.FileFormat.html)…".capitalized) {
                    exportData(data, format: .html)
                }
                .keyboardShortcut("e", modifiers: [.command, .option, .shift])
            }
            CommandGroup(replacing: .textFormatting) {
                Button("Remove Videos Filter") {
                    data.filter = .none
                }
                .keyboardShortcut(.delete, modifiers: [.command])
            }
            CommandGroup(replacing: .toolbar) {
                Button("Refresh Videos") {
                    data.load()
                }
                .keyboardShortcut("r", modifiers: [.command])
            }
        }
        #else
        return self
        #endif
    }
    
    #if os(iOS)
    func importData(_ data: CouchData) {
        DocumentPicker.import(types: [.tabSeparatedText]) { url in
            guard let url: URL = url else {
                return
            }
            data.load(request: .custom(url))
        }
    }
    
    func exportData(_ data: CouchData, format: CouchData.FileFormat) {
        do {
            let url: URL = try .document(at: format.path(name: "Couchnado"))
            try data.write(to: url, file: format)
            DocumentPicker.export(url: url) { url in
                
            }
        } catch {
            data.error = error as? URLError ?? URLError(.badURL)
        }
    }
    #endif
}
