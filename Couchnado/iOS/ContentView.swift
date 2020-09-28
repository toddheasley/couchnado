import SwiftUI
import CouchData

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass: UserInterfaceSizeClass?
    
    // MARK: View
    var body: some View {
        switch horizontalSizeClass {
        case .compact:
            CompactView()
        default:
            RegularView()
        }
    }
}
