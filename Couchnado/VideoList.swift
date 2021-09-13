import SwiftUI
import CouchData

struct VideoList: View {
    @EnvironmentObject private var data: CouchData
    
    // MARK: View
    var body: some View {
        ScrollView {
            LazyVStack {
                DescriptionView(description: data.description)
                    .padding(.default)
                ForEach(data.videos) { video in
                    VideoView(video: video)
                }
            }
            .padding(.default)
        }
    }
}

struct Video_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        VideoList()
            .environmentObject(CouchData())
            .padding()
    }
}
