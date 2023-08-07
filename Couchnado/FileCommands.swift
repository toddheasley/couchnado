#if os(macOS)
import SwiftUI
import HyperCouch
import CouchData

struct FileCommands: View {
    @Observable class Options {
        var isImportingSpreadsheet: Bool = false
        var isExportingSpreadsheet: Bool = false
        var isExportingWebPage: Bool = false
    }
    
    @Environment(Options.self) private var options: Options
    @Environment(CouchData.self) private var data: CouchData
    
    // MARK: View
    var body: some View {
        VStack {
            Button("Import Spreadsheet…") {
                options.isImportingSpreadsheet = true
            }
            .keyboardShortcut("o", modifiers: .command)
            Divider()
            Button("Export Spreadsheet…") {
                options.isExportingSpreadsheet = true
            }
            .keyboardShortcut("s", modifiers: .command)
            .disabled(data.isEmpty)
            Button("Export Web Page…") {
                options.isExportingWebPage = true
            }
            .keyboardShortcut("s", modifiers: [.command, .option])
            .disabled(data.isEmpty)
        }
    }
}

#Preview {
    FileCommands()
        .environment(CouchData())
}
#endif
