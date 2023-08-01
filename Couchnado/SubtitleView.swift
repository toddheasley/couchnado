import SwiftUI
import HyperCouch

struct SubtitleView: View {
    let subtitle: String
    
    init(_ subtitle: String) {
        self.subtitle = subtitle
    }
    
    // MARK: View
    var body: some View {
        Text(subtitle)
            .font(.tableSubtitle)
            .truncationMode(.tail)
            .lineLimit(1)
    }
}

#Preview {
    SubtitleView("1993-2002, 2016-2018 series")
}
