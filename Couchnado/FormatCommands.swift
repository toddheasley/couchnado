import SwiftUI
import CouchData

struct FormatCommands: View {
    @EnvironmentObject private var data: CouchData
    
    // MARK: View
    var body: some View {
        Button("Remove Videos Filter") {
            data.filter = .none
        }
        .keyboardShortcut(.delete, modifiers: .command)
        .disabled(data.filter == .none)
    }
}

struct FormatCommands_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        FormatCommands()
            .environmentObject(CouchData())
            .padding()
    }
}


