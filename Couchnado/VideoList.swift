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
#if os(macOS) || os(iOS)
    @State private var items: [Item] = []
#endif
    
    // MARK: View
    var body: some View {
#if os(macOS) || os(iOS)
        ScrollView {
            LazyVStack(spacing: 0.0) {
                DescriptionView(data.description)
                    .foregroundColor(.tableForeground.opacity(0.75))
                ForEach(items) { item in
                    VideoView(item.video, index: item.index)
                }
            }
            .padding(.default)
        }
        .background(Color.tableBackground)
        .onChange(of: data.videos) { videos in
            var items: [Item] = []
            for (index, video) in videos.enumerated() {
                items.append(Item(video: video, index: index))
            }
            self.items = items
        }

#elseif os(tvOS)
        ScrollView {
            LazyVStack {
                DescriptionView(data.description)
                    .foregroundColor(.secondary)
                ForEach(data.videos) { video in
                    VideoLink(video)
                }
            }
            .padding(.default)
        }
#endif
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
