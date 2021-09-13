import SwiftUI
import CouchData

struct ViewCommands: View {
    @EnvironmentObject private var data: CouchData
    
    // MARK: View
    var body: some View {
        Button("Refresh Videos") {
            data.load()
        }
        .keyboardShortcut("r", modifiers: .command)
    }
}

struct ViewCommands_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        ViewCommands()
            .environmentObject(CouchData())
            .padding()
    }
}


