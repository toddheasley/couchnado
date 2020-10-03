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
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                DescriptionView(description: data.description)
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: .zero) {
                        ForEach(items) { item in
                            VideoView(item: item)
                        }
                    }
                    .background(Color(.systemBackground))
                    .cornerRadius(.radius)
                    .padding(.top, DescriptionView.size.height + 5.0)
                    .padding(.horizontal, .padding)
                    .padding(.bottom, max(.padding - proxy.safeAreaInsets.bottom, 0.0))
                }
            }
            .ignoresSafeArea()
        }
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
