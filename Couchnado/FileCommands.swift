import SwiftUI
import HyperCouch
import CouchData

struct FileCommands: View {
    @EnvironmentObject private var data: CouchData
    @State private var isImportingSpreadsheet: Bool = false
    @State private var isExportingSpreadsheet: Bool = false
    @State private var isExportingWebPage: Bool = false
    
    private func importSpreadsheet() {
        isImportingSpreadsheet = true
    }
    
    private func exportSpreadsheet() {
        isExportingSpreadsheet = true
    }
    
    private func exportWebPage() {
        isExportingWebPage = true
    }
    
    // MARK: View
    var body: some View {
        Button(action: importSpreadsheet) {
            Text("Import Spreadsheet…")
        }
        .keyboardShortcut("o", modifiers: .command)
        .spreadsheet(data, isImporting: $isImportingSpreadsheet)
        Divider()
        Button(action: exportSpreadsheet) {
            Text("Export Spreadsheet…")
        }
        .keyboardShortcut("s", modifiers: .command)
        .spreadsheet(data, isExporting: $isExportingSpreadsheet)
        .disabled(data.isEmpty)
        Button(action: exportWebPage) {
            Text("Export Web Page…")
        }
        .keyboardShortcut("s", modifiers: [.command, .option])
        .webPage(data, title: App.title, isExporting: $isExportingWebPage)
        .disabled(data.isEmpty)
    }
}

struct FileCommands_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        FileCommands()
            .environmentObject(CouchData())
            .padding()
    }
}

