import SwiftUI
import CouchData

struct ContentView: View {
    @EnvironmentObject var data: CouchData
    
    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSize
    #endif
    
    var body: some View {
        VStack {
            SearchView(filter: $data.filter)
            .padding(10.0)
            FormatPicker(filter: $data.filter)
            .padding(10.0)
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
