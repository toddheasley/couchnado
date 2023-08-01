#if os(macOS) || os(iOS)
import SwiftUI
import HyperCouch
import CouchData

struct FileCommands: View {
    @Environment(CouchData.self) private var data: CouchData
    @State private var isImportingSpreadsheet: Bool = false
    @State private var isExportingSpreadsheet: Bool = false
    @State private var isExportingWebPage: Bool = false
    
    // MARK: View
    var body: some View {
        VStack {
            Button("Import Spreadsheet…") {
                isImportingSpreadsheet = true
            }
            .keyboardShortcut("o", modifiers: .command)
            .spreadsheet(data, isImporting: $isImportingSpreadsheet)
            Divider()
            Button("Export Spreadsheet…") {
                isExportingSpreadsheet = true
            }
            .keyboardShortcut("s", modifiers: .command)
            .spreadsheet(data, isExporting: $isExportingSpreadsheet)
            .disabled(data.isEmpty)
            Button("Export Web Page…") {
                isExportingWebPage = true
            }
            .keyboardShortcut("s", modifiers: [.command, .option])
            .webPage(data, title: App.title, isExporting: $isExportingWebPage)
            .disabled(data.isEmpty)
        }
    }
}

#Preview {
    FileCommands()
        .environment(CouchData())
}
#endif
