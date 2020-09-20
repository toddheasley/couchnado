import SwiftUI
import CouchData

struct MainView: View {
    @EnvironmentObject private var data: CouchData
    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass: UserInterfaceSizeClass?
    #endif
    
    // MARK: View
    var body: some View {
        VStack(spacing: .vertical) {
            SearchView(filter: $data.filter)
                .padding(.horizontal, .horizontal)
            FormatPicker(filter: $data.filter)
                .padding(.horizontal, .horizontal)
            GenreList(genres: data.genres, filter: $data.filter)
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
