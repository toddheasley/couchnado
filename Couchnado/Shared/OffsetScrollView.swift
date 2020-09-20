import SwiftUI

struct OffsetScrollView<Content>: View where Content: View {
    let axes: Axis.Set
    let showsIndicators: Bool
    let content: Content
    @Binding var offset: CGPoint
    
    init(_ axes: Axis.Set = .vertical, showsIndicators: Bool = true, offset: Binding<CGPoint>, @ViewBuilder content: () -> Content) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        self.content = content()
        self._offset = offset
    }
    
    // MARK: View
    var body: some View {
        GeometryReader { outer in
            ScrollView(axes, showsIndicators: showsIndicators) {
                ScrollViewReader { _ in
                    ZStack {
                        GeometryReader { inner in
                            OffsetPreference(outer, inner)
                        }
                        self.content
                    }
                }
            }
            .onPreferenceChange(OffsetPreference.Key.self) { value in
                self.offset = value[0]
            }
        }
    }
}

fileprivate struct OffsetPreference: View {
    struct Key: PreferenceKey {
        
        // MARK: PreferenceKey
        static var defaultValue: [CGPoint] = [.zero]
        
        static func reduce(value: inout [CGPoint], nextValue: () -> [CGPoint]) {
            value.append(contentsOf: nextValue())
        }
    }
    
    let offset: CGPoint
    
    init(_ outer: GeometryProxy, _ inner: GeometryProxy) {
        offset = CGPoint(x: outer.frame(in: .global).minX - inner.frame(in: .global).minX, y: outer.frame(in: .global).minY - inner.frame(in: .global).minY)
    }
    
    // MARK: View
    var body: some View {
        Color.clear
            .preference(key: Key.self, value: [offset])
    }
}
