#if os(macOS) || os(iOS)
import SwiftUI
import CouchData

struct ViewCommands: View {
    @Environment(CouchData.self) private var data: CouchData
    
    // MARK: View
    var body: some View {
        Button("Refresh Videos") {
            Task { [weak data] in
                await data?.load()
            }
        }
        .keyboardShortcut("r", modifiers: .command)
    }
}

#Preview {
    ViewCommands()
        .environment(CouchData())
}
#endif
