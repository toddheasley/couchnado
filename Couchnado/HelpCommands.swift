#if os(macOS) || os(iOS)
import SwiftUI
import CouchData

struct HelpCommands: View {
    
    // MARK: View
    var body: some View {
        VStack {
            Link("GitHub Repository", destination: .repo)
            Link("HyperCouch", destination: .docs)
        }
    }
}

#Preview {
    HelpCommands()
}
#endif
