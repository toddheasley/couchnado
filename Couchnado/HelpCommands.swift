import SwiftUI
import CouchData

struct HelpCommands: View {
    private func viewSource() {
        NSWorkspace.shared.open(.repo)
    }
    
    // MARK: View
    var body: some View {
        Button(action: viewSource) {
            Text("\(App.title) Documentation and Source Code")
        }
    }
}

struct HelpCommands_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        HelpCommands()
            .padding()
    }
}
