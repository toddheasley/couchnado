import SwiftUI
import CouchData

struct VideoList: View {
    @EnvironmentObject private var data: CouchData
    
    // MARK: View
    var body: some View {
        VStack {
            Text("Videos (\(data.videos.count))")
        }
        .frame(idealWidth: .infinity, maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}
