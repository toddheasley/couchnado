import SwiftUI
import CouchData

import SwiftUI
import CouchData

struct RegularView: View {
    @EnvironmentObject private var data: CouchData
    
    // MARK: View
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .trailing) {
                VideoList()
                    .frame(width: proxy.size.width - SideView.offset(show: data.showFilter).x)
                SideView()
            }
        }
    }
}

fileprivate struct SideView: View {
    static func offset(show: Bool = true) -> CGPoint {
        return CGPoint(x: show ? 320.0 : .zero, y: .zero)
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
    
    private let width: CGFloat = Self.offset().x + 24.0
    
    private var offset: CGPoint {
        return CGPoint(x: data.showFilter ? 0.0 : (0.0 - Self.offset().x), y: .zero)
    }
    
    private func dragEnded(drag: DragGesture.Value) {
        guard abs(drag.translation.width) > 44.0 else {
            return
        }
        data.showFilter.toggle()
    }
            
    // MARK: View
    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: .zero) {
                VStack(spacing: 10.0) {
                    SearchView(filter: $data.filter)
                        .padding(.horizontal, .horizontal)
                        .padding(.vertical, .vertical)
                    FormatPicker(filter: $data.filter)
                        .padding(.horizontal, .horizontal)
                    GenreList(genres: data.genres, filter: $data.filter)
                }
                .frame(height: proxy.size.height)
                .background(Color.secondaryBackground
                                .frame(height: proxy.size.height * 2.0))
                Divider()
                    .ignoresSafeArea()
                DragIndicator(orientation: .vertical)
                    .padding(.leading, .vertical)
                    .padding(.trailing, .horizontal)
            }
            .onReceive(data.$showFilter) { showFilter in
                SearchView.endEditing()
            }
            .frame(width: width)
            .offset(x: min(offset.x + dragMode.translation.width, .zero))
            .animation(.interpolatingSpring)
            .gesture(DragGesture()
                        .updating($dragMode) { drag, mode, _ in
                            mode = .dragging(translation: drag.translation)
                        }
                        .onEnded(dragEnded))
        }
    }
}
