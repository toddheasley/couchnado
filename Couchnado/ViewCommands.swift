import SwiftUI
import CouchData

struct ViewCommands: View {
    @Environment(CouchData.self) private var data: CouchData
    
    // MARK: View
    var body: some View {
        Button("Refresh Videos") {
            data.load()
        }
        .keyboardShortcut("r", modifiers: .command)
    }
}

#Preview {
    ViewCommands()
        .environment(CouchData())
}
