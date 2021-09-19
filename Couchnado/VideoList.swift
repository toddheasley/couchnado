import SwiftUI
import CouchData

struct VideoList: View {
    private struct Item: Identifiable {
        let video: Video
        let index: Int
        
        // MARK: Identifiable
        var id: String {
            return video.id
        }
    }
    
    @EnvironmentObject private var data: CouchData
    @State private var items: [Item] = []
    
    // MARK: View
    var body: some View {
        ScrollView {
            LazyVStack {
                DescriptionView(data.description)
                ForEach(items) { item in
#if os(tvOS)
                    VideoLink(item.video)
#else
                    VideoView(item.video, index: item.index)
#endif
                }
            }
            .padding(.default)
        }
        .onChange(of: data.videos) { videos in
            var items: [Item] = []
            for (index, video) in videos.enumerated() {
                items.append(Item(video: video, index: index))
            }
            self.items = items
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
