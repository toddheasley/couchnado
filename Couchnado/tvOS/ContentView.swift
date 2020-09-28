import SwiftUI
import CouchData

struct ContentView: View {
    
    // MARK: View
    var body: some View {
        HStack(alignment: .top, spacing: .zero) {
            GenreList()
            Divider()
            VideoList()
        }
    }
}
