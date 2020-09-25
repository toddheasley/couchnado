import SwiftUI
import CouchData

struct WideView: View {
    @EnvironmentObject private var data: CouchData
    
    // MARK: View
    var body: some View {
        VStack {
            Text("Videos (\(data.videos.count))")
        }
    }
}
