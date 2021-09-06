import SwiftUI
import CouchData

struct ContentView: View {
    @EnvironmentObject private var data: CouchData
    
    // MARK: View
    var body: some View {
        Text("\(data.videos.count) videos")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
