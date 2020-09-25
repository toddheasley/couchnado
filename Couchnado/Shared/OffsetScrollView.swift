import SwiftUI

struct OffsetScrollView<Content>: View where Content: View {
    let axes: Axis.Set
    let content: Content
    @Binding var offset: CGPoint
    
    init(_ axes: Axis.Set = .vertical, offset: Binding<CGPoint>, @ViewBuilder content: () -> Content) {
        self.axes = axes
        self.content = content()
        self._offset = offset
    }
    
    // MARK: View
    var body: some View {
        GeometryReader { outer in
            ScrollView(axes) {
                ScrollViewReader { _ in
                    ZStack {
                        GeometryReader { inner in
                            OffsetPreference(outer, inner)
                        }
                        content
                    }
                }
            }
            .onPreferenceChange(OffsetPreference.Key.self) { value in
                offset = value[0]
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
