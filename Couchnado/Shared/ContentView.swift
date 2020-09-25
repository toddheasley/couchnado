import SwiftUI
import CouchData

struct ContentView: View {
    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass: UserInterfaceSizeClass?
    #endif
    
    // MARK: View
    var body: some View {
        #if os(iOS)
        switch horizontalSizeClass {
        case .compact:
            CompactView()
        default:
            RegularView()
        }
        #elseif os(tvOS)
        WideView()
        #endif
    }
}
