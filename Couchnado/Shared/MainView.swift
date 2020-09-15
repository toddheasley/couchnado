import SwiftUI
import CouchData

struct MainView: View {
    @EnvironmentObject private var data: CouchData
    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass: UserInterfaceSizeClass?
    #endif
    
    // MARK: View
    var body: some View {
        VStack {
            SearchView(filter: $data.filter)
                .padding(10.0)
            FormatPicker(filter: $data.filter)
                .padding(10.0)
            Spacer()
            Text("Videos: \(data.videos.count)")
                .padding(10.0)
        }
        .padding(20.0)
    }
}

struct MainView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        MainView()
            .environmentObject(CouchData())
    }
}
