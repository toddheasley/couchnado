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
    
    @EnvironmentObject private var data: CouchData
    
    // MARK: View
    var body: some View {
        switch configuration {
        case .compact:
            Text("compact (\(data.videos.count))")
        case .standard:
            Text("standard (\(data.videos.count))")
        case .basic:
            Text("basic (\(data.videos.count))")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        MainView()
            .environmentObject(CouchData())
    }
}
