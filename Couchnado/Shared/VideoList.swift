import SwiftUI
import CouchData

struct VideoList: View {
    @EnvironmentObject private var data: CouchData
    @State private var offset: CGPoint = .zero
    
    // MARK: View
    var body: some View {
        VStack(spacing: 0.0) {
            HeaderView()
                .zIndex(1)
            ZStack(alignment: .top) {
                OffsetScrollView(offset: $offset) {
                    LazyVStack(alignment: .leading) {
                        ForEach(data.videos) { video in
                            VideoView(video: video)
                        }
                    }
                    .padding(.horizontal, .horizontal * 2.0)
                    .padding(.vertical, .vertical)
                }
                Divider()
                    .opacity(offset.y > 5.0 ? 1.0 : 0.0)
            }
            .zIndex(0)
        }
        .ignoresSafeArea()
    }
}

fileprivate struct HeaderView: View {
    @EnvironmentObject private var data: CouchData
    
    // MARK: View
    var body: some View {
        #if targetEnvironment(macCatalyst)
        HStack(alignment: .center) {
            Spacer()
            Text("Videos (\(data.videos.count))")
            Spacer()
        }
        .frame(height: 37.0)
        .background(Color.background)
        #else
        Text("Videos (\(data.videos.count))")
        #endif
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
