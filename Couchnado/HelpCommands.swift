import SwiftUI
import CouchData

struct HelpCommands: View {
    
    // MARK: View
    var body: some View {
        Button(action: {
            NSWorkspace.shared.open(.repo)
        }) {
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
