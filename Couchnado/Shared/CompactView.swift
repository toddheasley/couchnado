import SwiftUI
import CouchData

struct CompactView: View {
    
    // MARK: View
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                VideoList()
                    .frame(height: proxy.size.height - FilterView.offset.y)
                FilterView()
            }
        }
    }
}


fileprivate struct FilterView: View {
    static var offset: CGPoint {
        return CGPoint(x: .zero, y: (UIFontMetrics.default.scaledValue(for: 24.0) + 57.0))
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
            return CGPoint(x: .zero, y: .vertical)
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
                VStack(spacing: 10.0) {
                    Divider()
                    DragIndicator(orientation: .horizontal)
                        .padding(.top, .vertical)
                        .padding(.bottom, -2.0)
                    SearchView(filter: $data.filter)
                        .padding(.horizontal, .horizontal)
                    FormatPicker(filter: $data.filter)
                        .padding(.horizontal, .horizontal)
                        .padding(.bottom, 1.0)
                        .opacity(data.showFilter ? 1.0 : 0.0)
                    GenreList(genres: data.genres, filter: $data.filter)
                        .opacity(data.showFilter ? 1.0 : 0.0)
                }
                .frame(width: proxy.size.width, height: proxy.size.height - offset().y)
            }
            .onReceive(data.$filter) { filter in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    data.showFilter = false
                }
            }
            .onReceive(data.$showFilter) { showFilter in
                guard showFilter else {
                    return
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    SearchView.endEditing()
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height * 2.0, alignment: .top)
            .background(Color.secondaryBackground.shadow(color: Color.shadow, radius: 5.0))
            .offset(y: offset(proxy).y + dragMode.translation.height)
            .animation(.interpolatingSpring)
            .gesture(DragGesture()
                        .updating($dragMode) { drag, mode, _ in
                            mode = .dragging(translation: drag.translation)
                        }
                        .onEnded(dragEnded))
        }
    }
}
