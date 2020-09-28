import SwiftUI
import CouchData

struct VideoList: View {
    @EnvironmentObject private var data: CouchData
    
    private var items: [VideoView.Item] {
        return data.videos.enumerated().map { index, video in
            return VideoView.Item(video: video, index: index)
        }
    }
    
    // MARK: View
    var body: some View {
        ZStack(alignment: .top) {
            DescriptionView(description: data.description)
            ScrollView {
                LazyVStack(alignment: .leading, spacing: .zero) {
                    ForEach(items) { item in
                        VideoView(item: item)
                    }
                }
                .background(Color.background)
                .cornerRadius(.radius)
                .padding(.top, DescriptionView.size.height + .vertical)
                .padding(.horizontal, .horizontal)
                .padding(.bottom, .radius + .vertical)
            }
        }
        .ignoresSafeArea()
    }
}

extension View {
    fileprivate func ignoresSafeArea() -> some View {
        #if targetEnvironment(macCatalyst)
        return ignoresSafeArea(edges: .top)
        #else
        return self
        #endif
    }
}
