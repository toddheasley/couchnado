import SwiftUI
import CouchData

struct VideoList: View {
    @EnvironmentObject private var data: CouchData
    
    // MARK: View
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                LazyVStack {
                    DescriptionView(description: data.description)
                        .padding()
                    ForEach(data.videos) { video in
                        VideoView(video: video, size: proxy.size)
                    }
                }
            }
        }
    }
}
