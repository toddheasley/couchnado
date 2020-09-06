import SwiftUI
import CouchData

struct MainView: View {
    enum Configuration {
        case compact, standard, basic
    }
    
    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass: UserInterfaceSizeClass?
    
    var configuration: Configuration {
        switch horizontalSizeClass {
        case .compact:
            return .compact
        default:
            return .standard
        }
    }
    #else
    let configuration: Configuration = .basic
    #endif
    
    init() {
        #if targetEnvironment(macCatalyst)
        for scene in UIApplication.shared.connectedScenes {
            (scene as? UIWindowScene)?.titlebar?.titleVisibility = .hidden
        }
        #endif
    }
    
    @State private var isPresented: Bool = true
    
    // MARK: View
    var body: some View {
        switch configuration {
        case .compact:
            Text("compact")
        case .standard:
            Text("standard")
        case .basic:
            Text("basic")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        MainView()
    }
}
