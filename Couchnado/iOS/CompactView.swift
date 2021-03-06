import SwiftUI
import CouchData

struct CompactView: View {
    
    // MARK: View
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                VideoList()
                    .frame(height: proxy.size.height - OverView.offset.y)
                OverView()
            }
        }
    }
}

fileprivate struct OverView: View {
    static var offset: CGPoint {
        return CGPoint(x: .zero, y: (UIFontMetrics.default.scaledValue(for: 27.0) + 59.0))
    }
    
    private enum DragMode {
        case dragging(translation: CGSize), inactive
        
        var translation: CGSize {
            switch self {
            case .dragging(let translation):
                return translation
            case .inactive:
                return .zero
            }
        }
    }
    
    @EnvironmentObject private var data: CouchData
    @GestureState private var dragMode: DragMode = .inactive
    
    private func offset(_ proxy: GeometryProxy? = nil) -> CGPoint {
        guard let proxy: GeometryProxy = proxy, !data.showFilter else {
            return .zero
        }
        return CGPoint(x: .zero, y: proxy.size.height - Self.offset.y)
    }
    
    private func dragEnded(drag: DragGesture.Value) {
        guard abs(drag.translation.height) > 44.0 else {
            return
        }
        data.showFilter.toggle()
    }
            
    // MARK: View
    var body: some View {
        GeometryReader { proxy in
            Group {
                VStack(spacing: .padding) {
                    Divider()
                    DragIndicator(orientation: .horizontal)
                    SearchView(filter: $data.filter)
                        .padding(.horizontal, .padding)
                    FormatPicker(filter: $data.filter)
                        .padding(.horizontal, .padding)
                        .opacity(data.showFilter ? 1.0 : 0.0)
                    GenreList(genres: data.genres, filter: $data.filter)
                        .opacity(data.showFilter ? 1.0 : 0.0)
                }
                .frame(width: proxy.size.width, height: proxy.size.height - offset().y)
            }
            .onReceive(data.$filter) { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    data.showFilter = false
                }
            }
            .onReceive(data.$showFilter) { showFilter in
                guard showFilter else {
                    return
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    SearchView.endEditing()
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height * 2.0, alignment: .top)
            .background(Color(.secondarySystemBackground).shadow(color: Color.secondary.opacity(0.5), radius: 3.0))
            .offset(y: offset(proxy).y + dragMode.translation.height)
            .animation(.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
            .gesture(DragGesture()
                        .updating($dragMode) { drag, mode, _ in
                            mode = .dragging(translation: drag.translation)
                        }
                        .onEnded(dragEnded))
        }
    }
}
