import SwiftUI
import CouchData

struct VideoList: View {
    @EnvironmentObject private var data: CouchData
    @State private var offset: CGPoint = .zero
    
    private var items: [VideoView.Item] {
        return data.videos.enumerated().map { index, video in
            return VideoView.Item(video: video, index: index)
        }
    }
    
    // MARK: View
    var body: some View {
        ZStack(alignment: .top) {
            HeaderView()
            GeometryReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: .zero) {
                        ForEach(items) { item in
                            VideoView(item: item, size: proxy.size)
                        }
                    }
                    .background(Color.background)
                    .cornerRadius(.radius)
                    .padding(.top, HeaderView.size.height + .vertical)
                    .padding(.horizontal, .horizontal)
                    .padding(.bottom, .radius + .vertical)
                }
            }
        }
        .ignoresSafeArea()
    }
}

fileprivate struct HeaderView: View {
    static var size: CGSize {
        return CGSize(width: .zero, height: (UIFontMetrics.default.scaledValue(for: 37.0) + 0.0))
    }
    
    private static var font: Font {
        #if targetEnvironment(macCatalyst)
        return .subheadline
        #else
        return Font.caption.weight(.semibold)
        #endif
    }
    
    @EnvironmentObject private var data: CouchData
    
    // MARK: View
    var body: some View {
        Text("\(data.description)")
            .font(Self.font)
            .truncationMode(.tail)
            .lineLimit(1)
            .foregroundColor(.secondary)
            .frame(height: Self.size.height)
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
