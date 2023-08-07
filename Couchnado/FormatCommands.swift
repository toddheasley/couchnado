#if os(macOS) || os(iOS)
import SwiftUI
import CouchData

struct FormatCommands: View {
    @Environment(CouchData.self) private var data: CouchData
    
    // MARK: View
    var body: some View {
        Button("Remove Videos Filter") {
            data.filter = .none
        }
        .keyboardShortcut(.delete, modifiers: .command)
        .disabled(data.filter == .none)
        .previewDisplayName("Remove Videos Filter")
    }
}

#Preview {
    FormatCommands()
        .environment(CouchData())
}
#endif
