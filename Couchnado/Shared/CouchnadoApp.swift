import SwiftUI
import Combine
import CouchData

@main
struct CouchnadoApp: App {
    @StateObject private var data: CouchData = CouchData()
    
    private func importData() {
        DocumentPicker.import(types: [.tabSeparatedText]) { url in
            guard let url: URL = url else {
                return
            }
            data.load(request: .custom(url))
        }
    }
    
    private func exportData(_ format: CouchData.FileFormat) {
        do {
            let url: URL = try .document(at: format.path(name: "Couchnado"))
            try data.write(to: url, file: format)
            DocumentPicker.export(url: url) { url in
                
            }
        } catch {
            
        }
    }
    
    // MARK: App
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(data)
        }
        .commands {
            CommandGroup(replacing: .help) {
                Button("Couchnado Documentation and Source Code") {
                    Safari.open(url: URL(string: "https://github.com/toddheasley/couchnado")!)
                }
            }
            CommandGroup(after: .newItem) {
                Button("Import \(CouchData.FileFormat.tsv)…".capitalized) {
                    importData()
                }
                .keyboardShortcut("o", modifiers: [.command, .shift])
                Divider()
                Button("Export \(CouchData.FileFormat.tsv)…".capitalized) {
                    exportData(.tsv)
                }
                .keyboardShortcut("s", modifiers: [.command, .shift])
                Button("Export \(CouchData.FileFormat.html)…".capitalized) {
                    exportData(.html)
                }
                .keyboardShortcut("s", modifiers: [.command, .option, .shift])
            }
            CommandGroup(replacing: .textFormatting) {
                Button("Reset Video Data Sort and Filter") {
                    data.sort = .default
                    data.filter = .none
                }
                .keyboardShortcut(.escape, modifiers: [])
            }
            CommandGroup(replacing: .toolbar) {
                Button("Refresh Video Data") {
                    data.load()
                }
                .keyboardShortcut("r", modifiers: [.command])
            }
        }
    }
}
