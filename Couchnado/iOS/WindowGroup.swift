import SwiftUI
import CouchData

extension WindowGroup {
    func commands(data: CouchData) -> some Scene {
        #if targetEnvironment(macCatalyst)
        for scene in UIApplication.shared.connectedScenes {
            (scene as? UIWindowScene)?.titlebar?.titleVisibility = .hidden
        }
        #endif
        return commands {
            CommandGroup(replacing: .help) {
                Button("Couchnado Documentation and Source Code") {
                    UIApplication.shared.open(URL(string: "https://github.com/toddheasley/couchnado")!)
                }
            }
            CommandGroup(after: .newItem) {
                if data.showImport {
                    Button("Import \(CouchData.FileFormat.tsv)…".capitalized) {
                        importData(data)
                    }
                    .keyboardShortcut("o", modifiers: [.command, .shift])
                    Divider()
                }
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
                Button("Toggle Filter View") {
                    data.showFilter.toggle()
                }
                .keyboardShortcut("f", modifiers: [.command])
                Button("Refresh Videos") {
                    data.load()
                }
                .keyboardShortcut("r", modifiers: [.command])
            }
        }
    }
    
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
            let url: URL = try .document(at: format.path(name: "Couchnado Online"))
            try data.write(to: url, file: format)
            DocumentPicker.export(url: url) { url in
                
            }
        } catch {
            data.error = error as? URLError ?? URLError(.badURL)
        }
    }
}
