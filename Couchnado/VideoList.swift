import SwiftUI
import CouchData

struct VideoList: View {
    @Environment(CouchData.self) private var data: CouchData
    @State private var items: [Item] = []
    
    private struct Item: Identifiable {
        let video: Video
        let index: Int
        
        init(_ video: Video, index: Int) {
            self.video = video
            self.index = index
            id = "\(index)"
        }
        
        // MARK: Identifiable
        let id: String
    }
    
    private var spacing: CGFloat? {
#if os(tvOS)
        return nil
#else
        return 1.0
#endif
    }
    
    // MARK: View
    var body: some View {
        ScrollView {
            LazyVStack(spacing: spacing) {
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
        .onChange(of: data.videos, initial: true) {
            items = data.videos.enumerated().map { Item($1, index: $0) }
        }
    }
}

struct Video_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        VideoList()
            .environment(CouchData())
    }
}
